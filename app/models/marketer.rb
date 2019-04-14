# == Schema Information
#
# Table name: marketers
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

class Marketer < ApplicationRecord

    # Validations
    validates_presence_of :name, message:'لا يكمن ترك خانت الاسم فارغه'
    validates_presence_of :city, message:'لا يكمن ترك خانت المدينه فارغه'
end
