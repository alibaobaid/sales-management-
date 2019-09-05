# == Schema Information
#
# Table name: mangers
#
#  id                   :bigint(8)        not null, primary key
#  city                 :string
#  final_manager_amount :integer          default(0), not null
#  for_him              :integer
#  name                 :string
#  phone_NO             :string
#  to_him               :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  country_id           :bigint(8)
#
# Indexes
#
#  index_mangers_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#

class Manger < ApplicationRecord

  # Associations
  has_many :deliveries, dependent: :destroy, inverse_of: :manger
  has_many :sales_operations, dependent: :destroy, inverse_of: :manger
  has_many :manger_discounts, dependent: :destroy, inverse_of: :manger
  belongs_to :country

  # Validations
  validates :name,  presence: true

  # Callback
  before_create :default_one_account
  before_destroy :not_deletable


  private

  def default_one_account
    errors.add(:base, 'لايمكن اضافة حساب اخر') and throw(:abort) if Manger.where(country_id: self.country_id).any?
  end

  def not_deletable
    errors.add(:base, 'لايمكنك حذف المدير الافتراضي') 
    throw(:abort) 
  end
end
