class CreateDelagator < ActiveRecord::Migration
  def change
    create_table :delagators do |t|
      t.integer :user_info_id
      t.integer :each_invest_amount
      t.integer :min_invest_amount
      t.integer :max_invest_period
      t.integer :min_remain_balance
      t.integer :status, :default => 0

      t.datetime :last_open_time
      t.datetime :last_invest_time
      t.timestamps
    end
  end
end
