class ChangeDefaupricisionOperationAmount < ActiveRecord::Migration
  def change
    change_column :account_operations, :op_amount, :decimal, :precision => 12, :scale => 2, :default => 0.00
  end
end
