class RemoveOldTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :deliveries
  end
  
  def down

  end
end
