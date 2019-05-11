class CreateMangerDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :manger_discounts do |t|
      t.references :manger, foreign_key: true
      t.string :Desc
      t.integer :value
      t.date :date_of_discount

      t.timestamps
    end
  end
end
