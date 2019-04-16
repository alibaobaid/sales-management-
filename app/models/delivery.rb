# == Schema Information
#
# Table name: deliveries
#
#  id               :bigint(8)        not null, primary key
#  commodity_amount :integer
#  commodity_type   :string
#  delivery_time    :datetime
#  delegate_id      :bigint(8)
#
# Indexes
#
#  index_deliveries_on_delegate_id  (delegate_id)
#
# Foreign Keys
#
#  fk_rails_...  (delegate_id => delegates.id)
#

class Delivery < ApplicationRecord
  include SpreadsheetArchitect
  
  # Associations
  belongs_to :delegate, inverse_of: :deliveries

  # Validations
  validates_presence_of :commodity_type, message:'لا يكمن ترك خانت نوع البضاعه فارغه'
  validates_presence_of :commodity_amount, message:'لا يكمن ترك خانت الكمية فارغه'
  validates_presence_of :delivery_time, message:'لا يكمن ترك خانت  تاريخ التسليم فارغه'
  validates_presence_of :delegate_id, message:'لا يكمن ترك خانت المندوب فارغه'

  # Callbacks
  after_create :set_amount_to_delegate
  # instance method
  def set_amount_to_delegate
    @current_delegate = Delegate.find(self.delegate_id) 
    if commodity_type == 'علب'
      @current_delegate.update(amount_of_box: @current_delegate.amount_of_box.to_i + commodity_amount )
    else 
      @current_delegate.update(amount_of_gallon: @current_delegate.amount_of_gallon.to_i + commodity_amount )
    end
  end

  def spreadsheet_columns
    [
      ['المندوب', delegate.name],
      ['نوع البضاعه', :commodity_type],
      ['الكميه', :commodity_amount],
      ['تاريخ التسليم', delivery_time.to_date]
    ]
  end
end
