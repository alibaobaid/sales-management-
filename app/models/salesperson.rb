class Salesperson < ApplicationRecord
    
  # Validations
  validates_presence_of :name , message:'لا يمكن ترك خانة الاسم فارغه'
end
