class UpdateNillColumns < ActiveRecord::Migration[5.2]
  def change
    change_column_default :delegates, :for_him, from: nil, to: 0
    change_column_default :delegates, :amount_of_box, from: nil, to: 0
    change_column_default :delegates, :amount_of_gallon, from: nil, to: 0
    change_column_default :marketers, :for_him, from: nil, to: 0
  end
end
