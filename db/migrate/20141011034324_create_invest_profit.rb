class CreateInvestProfit < ActiveRecord::Migration
  def change
    create_table :invest_profits do |t|
      t.integer :invest_id
      t.datetime :refund_time
      t.decimal :refund_amount
      t.timestamps
    end
  end
end
