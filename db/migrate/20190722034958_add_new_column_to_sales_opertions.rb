class AddNewColumnToSalesOpertions < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_operations, :customr_city, :string
  end
end
