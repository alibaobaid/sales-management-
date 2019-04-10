class Delegate < ApplicationRecord

    # Associations
    has_many   :deliveries, dependent: :destroy

    # Validations
    validates_presence_of :name, message:'لا يكمن ترك خانت الاسم فارغه'
    validates_presence_of :city, message:'لا يكمن ترك خانت المدينه فارغه'




end
