class ChangeDefaultDiscountRate < ActiveRecord::Migration
  def change
    change_column :invests, :discount_rate, :decimal, :precision => 12, :scale => 1, :default => 0.0
  end
end
