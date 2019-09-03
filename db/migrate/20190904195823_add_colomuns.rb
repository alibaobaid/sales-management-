class AddColomuns < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_operations, :final_manager_amount, :integer, :default =>  0, :null =>  false
    add_column :mangers, :final_manager_amount, :integer, :default =>  0, :null =>  false
  end
end
