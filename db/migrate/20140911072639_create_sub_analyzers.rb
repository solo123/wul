class CreateSubAnalyzers < ActiveRecord::Migration
  def change
    create_table :sub_analyzers do |t|
      t.integer :analyzer_id
      t.string :product_type
      t.decimal :total_principal, precision: 14, scale: 2, default: 0.00
      t.decimal :total_profit, precision: 14, scale: 2, default: 0.00
      t.decimal :punishment_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :resell_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :buyin_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :total_invest_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :invest_freeze_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :order_freeze_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :resell_profit, precision: 14, scale: 2, default: 0.00
      t.decimal :buyin_profit, precision: 14, scale: 2, default: 0.00
      t.decimal :resell_discount_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :buyin_discount_amount, precision: 14, scale: 2, default: 0.00
      t.decimal :resell_fee, precision: 14, scale: 2, default: 0.00
      t.decimal :remain_pricipal, precision: 14, scale: 2, default: 0.00
      t.decimal :remain_profit, precision: 14, scale: 2, default: 0.00
      t.timestamps
    end
  end
end
