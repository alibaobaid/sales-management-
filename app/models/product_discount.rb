# == Schema Information
#
# Table name: product_discounts
#
#  id            :bigint(8)        not null, primary key
#  amount        :integer
#  discount_date :date
#  product_type  :string
#  reason        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  delegate_id   :bigint(8)
#
# Indexes
#
#  index_product_discounts_on_delegate_id  (delegate_id)
#
# Foreign Keys
#
#  fk_rails_...  (delegate_id => delegates.id)
#

class ProductDiscount < ApplicationRecord
  
  # Associations
  belongs_to :delegate
  # Validations
  validates :amount,
            :discount_date,
            :product_type,
             presence: true
  validate :not_updatable_fields, on: :update
  
  # Callbacks
  after_create :update_delegate_account
  after_update :update_delegate_account_changes, if: :saved_change_to_amount?
  after_destroy :reveres_changes

  def update_delegate_account
    if product_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box.to_i - amount )
    else 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i - amount )
    end
  end

  def update_delegate_account_changes
    if product_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box.to_i + amount_before_last_save )
      delegate.update(amount_of_box: delegate.amount_of_box.to_i - amount )
    else
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i + amount_before_last_save ) 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i - amount )
    end
  end

  def reveres_changes
    if product_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box.to_i + amount )
    else 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i + amount )
    end
  end

  def not_updatable_fields
    errors.add(:base,'لا يمكن حفظ البيانات التي قمت بتعديله') and throw(:abort) if not_allowed_changes?
  end
  
  def not_allowed_changes?
    delegate_id_changed? || product_type_changed?
  end
end
