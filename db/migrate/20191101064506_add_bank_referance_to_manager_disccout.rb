class AddBankReferanceToManagerDisccout < ActiveRecord::Migration[5.2]
  def change
    add_reference :manger_discounts, :bank, index: true, foreign_key: true
  end
end
