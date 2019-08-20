class AddCountryReferance < ActiveRecord::Migration[5.2]
  def change
    add_reference :delegates, :country, index: true, foreign_key: true
    add_reference :deliveries, :country, index: true, foreign_key: true
    add_reference :marketers, :country, index: true, foreign_key: true
    add_reference :assistants, :country, index: true, foreign_key: true
    add_reference :mangers, :country, index: true, foreign_key: true
    add_reference :sales_operations, :country, index: true, foreign_key: true
    add_reference :bank_transfers, :country, index: true, foreign_key: true
    add_reference :manger_discounts, :country, index: true, foreign_key: true
    add_reference :users, :country, index: true, foreign_key: true
    add_reference :product_discounts, :country, index: true, foreign_key: true
  end
end
