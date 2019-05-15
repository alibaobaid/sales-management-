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
  
  # Callbacks
  after_create :update_delegate_account

  def update_delegate_account
    if product_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box - amount )
    else 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon - amount )
    end
  end
end
