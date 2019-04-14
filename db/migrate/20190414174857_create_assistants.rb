class CreateAssistants < ActiveRecord::Migration[5.2]
  def change
    create_table :assistants do |t|
      t.string :name
      t.string :city
      t.string :phone_NO
      t.integer :for_him
      t.integer :to_him

      t.timestamps
    end
  end
end
