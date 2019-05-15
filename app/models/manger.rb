# == Schema Information
#
# Table name: mangers
#
#  id         :bigint(8)        not null, primary key
#  city       :string
#  for_him    :integer
#  name       :string
#  phone_NO   :string
#  to_him     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Manger < ApplicationRecord

  # Validations
  validates :name, :city, presence: true
  
end
