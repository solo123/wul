class ChangeTypeOfDepnumInTrans < ActiveRecord::Migration
  def change
    change_column :transactions, :deposit_number, :string
  end
end
