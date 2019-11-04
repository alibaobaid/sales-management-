# == Schema Information
#
# Table name: countries
#
#  id   :bigint(8)        not null, primary key
#  name :string
#

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
  has_many :banks, dependent: :destroy
  has_many :external_employees, dependent: :destroy
  has_many :external_transfers, dependent: :destroy



  # Validations
  validates :name, presence: true, uniqueness: true

  def employees_hash
    [
      ['مندوب', 'Delegate'],
      ['مسوق', 'Marketer'],
      ['مساعد','Assistant'],
      ['موظف خارجي','ExternalEmployee']
    ]
  end
end
