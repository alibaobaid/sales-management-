# == Schema Information
#
# Table name: sales_operations
#
#  id                     :bigint(8)        not null, primary key
#  box_amount             :integer          default(0), not null
#  customr_city           :string
#  customr_no             :string
#  date                   :date             not null
#  delegate_commission    :float            not null
#  final_manager_amount   :float            default(0.0), not null
#  from_delegate_transfer :float
#  gallon_amount          :integer          default(0), not null
#  manager_commission     :float            default(0.0), not null
#  marketer_commission    :float            not null
#  operation_number       :integer
#  price                  :float            not null
#  to_manger_transfer     :float
#  to_marketer_transfer   :float
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  country_id             :bigint(8)
#  delegate_id            :bigint(8)        not null
#  manger_id              :bigint(8)        not null
#  marketer_id            :bigint(8)        not null
#
# Indexes
#
#  index_sales_operations_on_country_id        (country_id)
#  index_sales_operations_on_delegate_id       (delegate_id)
#  index_sales_operations_on_manger_id         (manger_id)
#  index_sales_operations_on_marketer_id       (marketer_id)
#  index_sales_operations_on_operation_number  (operation_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
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
  belongs_to :country

  # Scopes
  scope :on_date, -> (date) { where(date: date) }
  scope :between, -> (from, to) { where(date: from..to) }
  scope :delegate, -> (id) { where(delegate_id: id) }
  scope :marketer, -> (id) { where(marketer_id: id) }

  # Validations
  validates :gallon_amount,
            :box_amount,
            :date,
            :delegate_commission,
            :marketer_commission,
            :price ,
            :delegate_id,
            :marketer_id,
            :manger_id,
            presence: true
  # Callbacks
  before_validation :set_manger_value
  after_create :update_amount_of_delegate
  after_create :update_delegate_value
  after_create :update_marketrt_value
  after_create :update_manager_value
  after_create :create_bank_transfer_for_delegate
  after_create :create_bank_transfer_for_marketer
  after_create :update_assistants
  after_destroy :reverse_chnages
  after_update :update_amount_of_delegate_changes, if: [:saved_change_to_box_amount? || :saved_change_to_gallon_amount?]
  after_update :update_delegate_value_changes, if: [:saved_change_to_delegate_commission? || :saved_change_to_price?]
  after_update :update_marketrt_value_changes, if: [:saved_change_to_marketer_commission?]
  after_update :update_manager_value_changes, if: [:saved_change_to_marketer_commission? || :saved_change_to_delegate_commission? || :saved_change_to_price?]

  # Methods
  def set_manger_value
    self.manager_commission = price - (delegate_commission + marketer_commission )
    self.final_manager_amount =  assistants_amount.nil? ? manager_commission : manager_commission - assistants_amount
  end

  def update_amount_of_delegate
    delegate.update(amount_of_box: delegate.amount_of_box.to_i - box_amount)
    delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i - gallon_amount)
  end

  def update_delegate_value
    delegate.update(for_him: delegate.for_him.to_i + (delegate_commission - price))
  end

  def update_marketrt_value
    marketer.update(for_him: marketer.for_him.to_i + marketer_commission)
  end

  def update_manager_value
    manger.update(for_him: manger.for_him.to_i + manager_commission)
    manger.update(final_manager_amount: manger.final_manager_amount.to_i + final_manager_amount)
  end

  # this methods is for create bank transfer if the the price is entred within sale operation
  def create_bank_transfer_for_delegate
    return if from_delegate_transfer.nil?
    country.bank_transfers.create({ date_of_transfer: date, price: from_delegate_transfer, transfer_type:"ارسال", section_type:"مندوب", delegate_id: delegate_id })
  end

  def create_bank_transfer_for_marketer
    return if to_marketer_transfer.nil?
    country.bank_transfers.create({ date_of_transfer: date, price: to_marketer_transfer, transfer_type:"استلام", section_type:"مسوق", marketer_id: marketer_id })
  end

  def update_assistants
    country.assistants.each do |assistant|
      assistant.update(for_him: assistant.for_him.to_i + assistant.his_amount.to_i)
    end
  end

  def reverse_chnages
    delegate.update(amount_of_box: delegate.amount_of_box.to_i + box_amount)
    delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i + gallon_amount)
    delegate.update(for_him: delegate.for_him.to_i - (delegate_commission - price))
    marketer.update(for_him: marketer.for_him.to_i - marketer_commission)
    manger.update(for_him: manger.for_him.to_i - manager_commission)
    manger.update(final_manager_amount: manger.final_manager_amount.to_i - final_manager_amount)
    country.assistants.each do |assistant|
      assistant.update(for_him: assistant.for_him.to_i - assistant.his_amount.to_i)
    end
  end

  def not_allowed_changes?
    delegate_id_changed? || marketer_id_changed? || to_manger_transfer_changed? || to_marketer_transfer_changed? || from_delegate_transfer_changed? || commodity_type_changed?
  end

  def update_amount_of_delegate_changes
    delegate.update(amount_of_box: delegate.amount_of_box.to_i + box_amount_before_last_save)
    delegate.update(amount_of_box: delegate.amount_of_box.to_i - box_amount)
    delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i + gallon_amount_before_last_save )
    delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i - gallon_amount )
  end

  def update_delegate_value_changes
    delegate.update(for_him: delegate.for_him.to_i - (delegate_commission_before_last_save - price_before_last_save))
    delegate.update(for_him: delegate.for_him.to_i + (delegate_commission - price))
  end

  def update_marketrt_value_changes
    marketer.update(for_him: marketer.for_him.to_i - marketer_commission_before_last_save )
    marketer.update(for_him: marketer.for_him.to_i + marketer_commission )
  end

  def update_manager_value_changes
    manger.update(for_him: manger.for_him.to_i - manager_commission_before_last_save)
    manger.update(for_him: manger.for_him.to_i + manager_commission)
    manger.update(final_manager_amount: manger.final_manager_amount.to_i - final_manager_amount_before_last_save)
    manger.update(final_manager_amount: manger.final_manager_amount.to_i + final_manager_amount)
  end

  def assistants_amount
    @assistants_amount ||= country.assistants.pluck(:his_amount).inject(:+)
  end
end
