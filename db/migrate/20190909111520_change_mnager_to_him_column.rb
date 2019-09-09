class ChangeMnagerToHimColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :mangers, :to_him, :float
  end
end
