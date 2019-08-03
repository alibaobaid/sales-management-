# == Schema Information
#
# Table name: marketers
#
#  id         :bigint(8)        not null, primary key
#  city       :string
#  for_him    :integer
#  name       :string
#  phone_NO   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Marketer < ApplicationRecord
    
  # Associations
  has_many :sales_operations, dependent: :destroy
  has_many :bank_transfers, dependent: :destroy
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
end
