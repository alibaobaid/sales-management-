class CreateSalespeople < ActiveRecord::Migration[5.2]
  def change
    create_table :salespeople do |t|
      t.string :name
      t.string :city
      t.string :phone_NO
      t.integer :amount_of_box
      t.integer :amount_of_gallon
      t.integer :for_him
      t.integer :to_him

      t.timestamps
    end
  end
end
