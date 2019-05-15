class CreateSalesOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_operations do |t|
      t.date :date, null: false
      t.string :commodity_type, null: false
      t.integer :commodity_amount, null: false
      t.integer :price, null: false
      t.integer :delegate_commission, null: false
      t.integer :marketer_commission, null: false
      t.integer :from_delegate_transfer, null:true
      t.integer :to_marketer_transfer, null:true
      t.integer :to_manger_transfer, null:true
      t.references :delegate, foreign_key: true, index: true, null: false
      t.references :marketer, foreign_key: true, index: true, null: false
      t.references :manger,foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
