# == Schema Information
#
# Table name: banks
#
#  id         :bigint(8)        not null, primary key
#  balance    :float            default(0.0)
#  desc       :string
#  name       :string
#  country_id :bigint(8)
#
# Indexes
#
#  index_banks_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#

class Bank < ApplicationRecord
  # Associations
  belongs_to :country
  has_many :bank_transfers, dependent: :destroy
  has_many :manger_discounts, dependent: :destroy


  
  # Validations
  validates :name, presence: true, uniqueness: { scope: [:country_id] }
  validates :balance, presence: true
end
