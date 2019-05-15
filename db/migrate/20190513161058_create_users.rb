class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false, index: true
      t.string :password_digest, null: false, index: true
      t.string :role_type, null: false, index: true, default: 'مدير'
      t.boolean :is_default, default: false

      t.timestamps
    end
  end
end
