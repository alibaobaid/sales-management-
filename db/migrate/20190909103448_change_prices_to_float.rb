class ChangePricesToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :sales_operations, :delegate_commission, :float
    change_column :sales_operations, :final_manager_amount, :float
    change_column :sales_operations, :from_delegate_transfer, :float
    change_column :sales_operations, :manager_commission, :float
    change_column :sales_operations, :marketer_commission, :float
    change_column :sales_operations, :price, :float
    change_column :sales_operations, :to_manger_transfer, :float
    change_column :sales_operations, :to_marketer_transfer, :float
    change_column :bank_transfers, :price, :float
    change_column :delegates, :for_him, :float
    change_column :marketers, :for_him, :float
    change_column :assistants, :for_him, :float
    change_column :mangers, :for_him, :float
    change_column :mangers, :final_manager_amount, :float
    change_column :manger_discounts, :value, :float
  end
end
