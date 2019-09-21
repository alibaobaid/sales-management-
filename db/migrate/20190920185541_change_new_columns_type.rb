class ChangeNewColumnsType < ActiveRecord::Migration[5.2]
  def change
    change_column :sales_operations, :exchange_for_delegator, :float
    change_column :sales_operations, :exchange_for_marketer, :float
  end
end
