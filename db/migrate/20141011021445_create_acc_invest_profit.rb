class CreateAccInvestProfit < ActiveRecord::Migration
  def change
    create_table :account_invest_profits do |t|
      t.integer :account_sub_invest_id
      t.datetime :refund_time
      t.decimal :refund_amount, precision: 14, scale: 2, default: 0.00
      t.timestamps
    end
  end
end
