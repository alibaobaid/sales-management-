class AddNewColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_operations, :exchange_for_delegator, :integer, :default =>  0
    add_column :sales_operations, :exchange_for_marketer, :integer, :default =>  0
    add_column :bank_transfers, :note, :string 
  end
end
