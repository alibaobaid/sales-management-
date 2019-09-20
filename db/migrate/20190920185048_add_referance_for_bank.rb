class AddReferanceForBank < ActiveRecord::Migration[5.2]
  def change
    add_reference :bank_transfers, :bank, index: true, foreign_key: true
  end
end
