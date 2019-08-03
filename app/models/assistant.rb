# == Schema Information
#
# Table name: assistants
#
#  id         :bigint(8)        not null, primary key
#  city       :string
#  for_him    :integer
#  his_amount :integer
#  name       :string
#  phone_NO   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Assistant < ApplicationRecord

  # Associations
  has_many :bank_transfers, dependent: :destroy   
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
end
