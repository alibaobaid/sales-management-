class CreateExternalEmployee < ActiveRecord::Migration[5.2]
  def change
    create_table :external_employees do |t|
      t.string :name
      t.float :for_him
      t.string :phone_NO
      t.references :country, foreign_key: true, index: true, null: true
    end
  end
end
