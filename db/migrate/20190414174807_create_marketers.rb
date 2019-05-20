class CreateMarketers < ActiveRecord::Migration[5.2]
  def change
    create_table :marketers do |t|
      t.string :name
      t.string :city
      t.string :phone_NO
      t.integer :for_him

      t.timestamps
    end
  end
end
