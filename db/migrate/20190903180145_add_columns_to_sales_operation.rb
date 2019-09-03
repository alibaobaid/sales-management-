class AddColumnsToSalesOperation < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_operations, :manager_commission, :integer, :default =>  0, :null =>  false
    add_column :sales_operations, :gallon_amount, :integer, :default =>  0, :null =>  false
    add_column :sales_operations, :box_amount, :integer, :default =>  0, :null =>  false
  end
end
