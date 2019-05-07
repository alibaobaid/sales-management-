class CreateBankTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_transfers do |t|
      t.datetime :date_of_transfer
      t.string :transfer_type
      t.string :section_type
      t.references :delegate, foreign_key: true, index: true, null: true
      t.references :marketer, foreign_key: true, index: true, null: true
      t.references :manger,foreign_key: true, index: true, null: true
      t.integer :price

      t.timestamps
    end
  end
end
