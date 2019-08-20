class Country < ApplicationRecord
  
  # Associations
  has_many :bank_transfers, dependent: :destroy
  has_many :assistants, dependent: :destroy
  has_many :manger_discounts, dependent: :destroy
  has_many :delegates, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  has_many :mangers, dependent: :destroy
  has_many :marketers, dependent: :destroy
  has_many :product_discounts, dependent: :destroy
  has_many :sales_operations, dependent: :destroy
  has_many :users, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true
end