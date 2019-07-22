# == Schema Information
#
# Table name: sales_operations
#
#  id                     :bigint(8)        not null, primary key
#  commodity_amount       :integer          not null
#  commodity_type         :string           not null
#  customr_city           :string
#  customr_no             :string
#  date                   :date             not null
#  delegate_commission    :integer          not null
#  from_delegate_transfer :integer
#  marketer_commission    :integer          not null
#  operation_number       :integer
#  price                  :integer          not null
#  to_manger_transfer     :integer
#  to_marketer_transfer   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  delegate_id            :bigint(8)        not null
#  manger_id              :bigint(8)        not null
#  marketer_id            :bigint(8)        not null
#
# Indexes
#
#  index_sales_operations_on_delegate_id       (delegate_id)
#  index_sales_operations_on_manger_id         (manger_id)
#  index_sales_operations_on_marketer_id       (marketer_id)
#  index_sales_operations_on_operation_number  (operation_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (delegate_id => delegates.id)
#  fk_rails_...  (manger_id => mangers.id)
#  fk_rails_...  (marketer_id => marketers.id)
#

class SalesOperation < ApplicationRecord

  extend ImportFile

  # Associations
  belongs_to :delegate
  belongs_to :marketer
  belongs_to :manger
  scope :gallon, -> { where(commodity_type: "جالون") }
  scope :box, -> { where(commodity_type: "علب") }
  scope :gallon_and_on_date, -> (date) { where(date: date).gallon }
  scope :box_and_on_date, -> (date) { where(date: date).box }

  # Ex:- scope :active, -> {where(:active => true)}
  # Validations
  validates :commodity_amount,
            :commodity_type,
            :date,
            :delegate_commission,
            :marketer_commission,
            :price ,
            :delegate_id,
            :marketer_id,
            :manger_id,
            :customr_city,
            presence: true

  # Callbacks
  after_create :update_amount_of_delegate
  after_create :update_delegate_value
  after_create :update_marketrt_value
  after_create :update_manager_value
  after_create :create_bank_transfer_for_delegate
  after_create :create_bank_transfer_for_marketer
  after_create :create_bank_transfer_for_manger
  after_create :update_assistants




  def manager_commission
    price - delegate_commission - marketer_commission
  end

  def bank_commission
    price - delegate_commission - marketer_commission
  end

  def update_amount_of_delegate
    if commodity_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box.to_i - commodity_amount )
    else
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i - commodity_amount )
    end
  end

  def update_delegate_value
    delegate.update(for_him: delegate.for_him.to_i + delegate_commission - price)
  end

  def update_marketrt_value
    marketer.update(for_him: marketer.for_him.to_i + marketer_commission )
  end

  def update_manager_value
    manger.update(for_him: manger.for_him.to_i + manager_commission  )
  end

  # this methods is for create bank transfer if the the price is entred within sale operation
  def create_bank_transfer_for_delegate
    return if from_delegate_transfer.nil?
    BankTransfer.create({date_of_transfer: date, price: from_delegate_transfer, transfer_type:"ارسال", section_type:"مندوب", delegate_id: delegate_id})
  end

  def create_bank_transfer_for_marketer
    return if to_marketer_transfer.nil?
    BankTransfer.create({date_of_transfer: date, price: to_marketer_transfer, transfer_type:"استلام", section_type:"مسوق", marketer_id: marketer_id})
  end

  def create_bank_transfer_for_manger
    return if to_manger_transfer.nil?
    BankTransfer.create({date_of_transfer: date, price: to_manger_transfer, transfer_type:"استلام", section_type:"مدير", manger_id: manger_id})
  end

  def update_assistants
    Assistant.all.each do |assistant|
      assistant.update(for_him: assistant.for_him.to_i + assistant.his_amount.to_i)
    end
  end

end
