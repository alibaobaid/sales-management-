class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :name
      t.float :balance, default: 0
      t.string :desc
      t.references :country, foreign_key: true, index: true, null: true
    end
  end
end
