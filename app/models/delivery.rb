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
  validates :commodity_type, :commodity_amount, :delivery_time, :delegate_id, presence: true

  # Callbacks
  after_create :set_amount_to_delegate
  # instance method
  def set_amount_to_delegate
    if commodity_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box + commodity_amount )
    else 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon + commodity_amount )
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
