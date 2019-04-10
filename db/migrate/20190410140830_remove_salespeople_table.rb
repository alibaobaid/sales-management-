class RemoveSalespeopleTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :salespeople
  end

  def down
  end
end
