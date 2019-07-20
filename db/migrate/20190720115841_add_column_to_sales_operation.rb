class AddColumnToSalesOperation < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_operations, :customr_no, :string
  end
end
