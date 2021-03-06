class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens do |t|
      t.string :value
      t.references :user, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
