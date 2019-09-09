class RemoveUselessColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :sales_operations, :commodity_amount
    remove_column :sales_operations, :commodity_type
  end
end
