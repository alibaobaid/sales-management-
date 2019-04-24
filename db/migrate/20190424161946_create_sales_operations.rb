class CreateSalesOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_operations do |t|
      t.date :date, null: false
      t.string :commodity_type, null: false
      t.integer :commodity_amount, null: false
      t.float :price, null: false
      t.float :delegate_commission, null: false
      t.float :marketer_commission, null: false
      t.references :delegate, foreign_key: true, index: true, null: false
      t.references :marketer, foreign_key: true, index: true, null: false
      

      t.timestamps
    end
  end
end
