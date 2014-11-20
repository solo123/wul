class CreateAnalyzers < ActiveRecord::Migration
  def change
    create_table :analyzers do |t|
      t.string :product
      t.integer :owner_num
      t.decimal :invest_num, precision: 14, scale: 2, default: 0.00
      t.integer :user_info_id
      t.decimal :total_charge_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :total_withdraw_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :cash_freeze_amount , precision: 14, scale: 2, default: 0.00
      t.decimal :fee, precision: 14, scale: 2, default: 0.00
      t.decimal :coupon_profit, precision: 14, scale: 2, default: 0.00

      t.timestamps
    end
  end
end
