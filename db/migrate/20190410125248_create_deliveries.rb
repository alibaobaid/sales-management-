class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.string :commodity_type
      t.integer :commodity_amount
      t.datetime :delivery_time
      t.references :delegate, foreign_key: true

    end
  end
end
