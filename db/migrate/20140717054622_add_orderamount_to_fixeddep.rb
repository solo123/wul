class AddOrderamountToFixeddep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :order_amount, :decimal, :default => 0.0
  end
end
