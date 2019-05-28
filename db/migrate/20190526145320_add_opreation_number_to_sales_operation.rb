class AddOpreationNumberToSalesOperation < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_operations, :operation_number, :integer
    add_index :sales_operations, :operation_number, unique: true
  end
end
