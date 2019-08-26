# == Schema Information
#
# Table name: marketers
#
#  id         :bigint(8)        not null, primary key
#  city       :string
#  for_him    :integer          default(0)
#  name       :string
#  phone_NO   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint(8)
#
# Indexes
#
#  index_marketers_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#

class Marketer < ApplicationRecord
    
  # Associations
  has_many :sales_operations, dependent: :destroy
  has_many :bank_transfers, dependent: :destroy
  belongs_to :country
  # Validations
  validates :name, presence: true, uniqueness: { scope: [:country_id] }
  validates :city, presence: true
  validates :for_him, presence: true
end
