class CreateMonthDeposits < ActiveRecord::Migration
  def change
    create_table :month_deposits do |t|
      t.string :deposit_number
      t.string :transaction_number
      t.string :address
      t.string :usage
      t.text :usage_detail
      t.string :credit_level
      t.decimal :annual_rate, precision: 5, scale: 2
      t.decimal :amount, precision: 12, scale: 2
      t.integer :repayment_period
      t.string :repayment_method
      t.decimal :each_repayment_amount, precision: 12, scale: 2
      t.decimal :free_invest_amount, precision: 12, scale: 2
      t.datetime :invest_end_date
      t.string :remark
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
