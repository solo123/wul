class CreateFixedDeposits < ActiveRecord::Migration
  def change
    create_table :fixed_deposits do |t|
      t.string :deposit_number
      t.decimal :total_amount, precision: 12, scale: 2 
      t.decimal :annual_rate, precision: 5, scale: 2
      t.integer :repayment_period
      t.string :guarantee
      t.decimal :free_invest_amount, precision: 12, scale: 2
      t.string :detail
      t.string :income_method
      t.string :join_date
      t.string :join_condition
      t.date :expiring_date
      t.string :repayment_method
      t.string :premature_redemption
      t.string :fee

      t.timestamps
    end
  end
end
