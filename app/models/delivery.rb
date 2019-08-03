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
  validate :not_updatable_fields, on: :update

  # Callbacks
  after_create :set_amount_to_delegate
  after_update :update_delegate_account_changes, if: :saved_change_to_commodity_amount?
  after_destroy :reveres_changes
  
  # instance method
  def set_amount_to_delegate
    if commodity_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box.to_i + commodity_amount )
    else 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i + commodity_amount )
    end
  end

  def update_delegate_account_changes
    if commodity_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box.to_i - commodity_amount_before_last_save )
      delegate.update(amount_of_box: delegate.amount_of_box.to_i + commodity_amount )
    else
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i - commodity_amount_before_last_save ) 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i + commodity_amount )
    end
  end

  def reveres_changes
    if commodity_type == 'علب'
      delegate.update(amount_of_box: delegate.amount_of_box.to_i - commodity_amount )
    else 
      delegate.update(amount_of_gallon: delegate.amount_of_gallon.to_i - commodity_amount )
    end
  end

  def not_updatable_fields
    errors.add(:base,'لا يمكن حفظ البيانات التي قمت بتعديله') and throw(:abort) if not_allowed_changes?
  end
  
  def not_allowed_changes?
    delegate_id_changed? || commodity_type_changed?
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
