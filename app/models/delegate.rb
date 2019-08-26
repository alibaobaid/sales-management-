# == Schema Information
#
# Table name: delegates
#
#  id               :bigint(8)        not null, primary key
#  amount_of_box    :integer          default(0)
#  amount_of_gallon :integer          default(0)
#  city             :string
#  for_him          :integer          default(0)
#  name             :string
#  phone_NO         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  country_id       :bigint(8)
#
# Indexes
#
#  index_delegates_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#

class Delegate < ApplicationRecord

  # Associations
  has_many :deliveries, dependent: :destroy, inverse_of: :delegate
  has_many :sales_operations , dependent: :destroy, inverse_of: :delegate
  has_many :bank_transfers, dependent: :destroy
  has_many :product_discounts, dependent: :destroy
  belongs_to :country       
  # Validations
  validates :name, presence: true, uniqueness: { scope: [:country_id] }
  validates :city, presence: true
  validates :for_him, presence: true
  validates :amount_of_box, presence: true
  validates :amount_of_gallon, presence: true

end
