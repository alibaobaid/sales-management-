class CreateExternalTransfer < ActiveRecord::Migration[5.2]
  def change
    create_table :external_transfers do |t|
      t.date :date_of_transfer
      t.references :sender, polymorphic: true, index: true
      t.references :receiver, polymorphic: true, index: true
      t.references :country, foreign_key: true, index: true, null: true
      t.float :price
    end
  end
end
