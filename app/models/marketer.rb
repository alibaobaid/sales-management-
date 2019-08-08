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
#

class Marketer < ApplicationRecord
    
  # Associations
  has_many :sales_operations, dependent: :destroy
  has_many :bank_transfers, dependent: :destroy
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :city, presence: true

	def self.for_him_total
		Marketer.all.pluck(:for_him).sum
	end
end
