# == Schema Information
#
# Table name: sales_operations
#
#  id                  :bigint(8)        not null, primary key
#  commodity_amount    :integer          not null
#  commodity_type      :string           not null
#  date                :date             not null
#  delegate_commission :float            not null
#  marketer_commission :float            not null
#  price               :float            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  delegate_id         :bigint(8)        not null
#  manger_id           :bigint(8)        not null
#  marketer_id         :bigint(8)        not null
#
# Indexes
#
#  index_sales_operations_on_delegate_id  (delegate_id)
#  index_sales_operations_on_manger_id    (manger_id)
#  index_sales_operations_on_marketer_id  (marketer_id)
#
# Foreign Keys
#
#  fk_rails_...  (delegate_id => delegates.id)
#  fk_rails_...  (manger_id => mangers.id)
#  fk_rails_...  (marketer_id => marketers.id)
#

class SalesOperation < ApplicationRecord
  # Associations
  belongs_to :delegate
  belongs_to :marketer
  belongs_to :manger
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
            presence: true
  
  # Callbacks
  after_create :update_amount_of_delegate
  after_create :update_delegate_value
  after_create :update_marketrt_value
  after_create :update_manager_value


  def manager_commission
    price - delegate_commission 
  end

  def update_amount_of_delegate
    if commodity_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box - commodity_amount )
    else 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon - commodity_amount )
    end
  end

  def update_delegate_value
    delegate.update(for_him: delegate.for_him.to_i + delegate_commission - price)
  end

  def update_marketrt_value
    marketer.update(for_him: marketer.for_him.to_i + marketer_commission )
  end

  def update_manager_value
    manger.update(for_him: manger.for_him.to_i + manager_commission )
  end
end
