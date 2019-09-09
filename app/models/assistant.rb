# == Schema Information
#
# Table name: assistants
#
#  id         :bigint(8)        not null, primary key
#  city       :string
#  for_him    :float
#  his_amount :integer
#  name       :string
#  phone_NO   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint(8)
#
# Indexes
#
#  index_assistants_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#

class Assistant < ApplicationRecord

  # Associations
  has_many :bank_transfers, dependent: :destroy
  belongs_to :country
  # Validations
  validates :name, presence: true, uniqueness: { scope: [:country_id] }
  validates :city, presence: true
  validates :his_amount, presence: true
end
