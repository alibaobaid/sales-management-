# == Schema Information
#
# Table name: delegates
#
#  id               :bigint(8)        not null, primary key
#  amount_of_box    :integer
#  amount_of_gallon :integer
#  city             :string
#  for_him          :integer
#  name             :string
#  phone_NO         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Delegate < ApplicationRecord

  # Associations
  has_many :deliveries, dependent: :destroy, inverse_of: :delegate
  has_many :sales_operations , dependent: :destroy, inverse_of: :delegate
  has_many :bank_transfers, dependent: :destroy
  has_many :product_discounts, dependent: :destroy        
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :city, presence: true

end
