class AddDiscountRateInvest < ActiveRecord::Migration
  def change
    add_column :invests, :discount_rate, :decimal, :default => 0
  end
end
