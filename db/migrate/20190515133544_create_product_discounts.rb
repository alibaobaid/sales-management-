class CreateProductDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :product_discounts do |t|
      t.string :product_type
      t.string :reason
      t.integer :amount
      t.date :discount_date
      t.references :delegate, foreign_key: true

      t.timestamps
    end
  end
end
