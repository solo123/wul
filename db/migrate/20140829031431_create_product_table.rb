class CreateProductTable < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :deposit_number
      t.decimal :total_amount, precision: 12, scale: 2
      t.decimal :annual_rate, precision: 5,  scale: 2
      t.integer :repayment_period
      t.string  :repayment_method, :default => "profit"
      t.decimal :each_repayment_amount, precision: 12, scale: 2
      t.string  :guarantee
      t.decimal :free_invest_amount, precision: 10, scale: 2
      t.decimal :fixed_invest_amount, precision: 10, scale: 2, default:0
      t.string  :detail
      t.string  :income_method
      t.date :join_date
      t.string   :join_condition
      t.date     :expiring_date

      t.string   :premature_redemption
      t.integer  :fee, :default => 1
      t.integer  :owner_num, default: 0
      t.decimal  :order_amount, precision: 10, scale: 0, default: 0
      t.string   :product_type, default: "fixed"
      t.string   :stage, default: "未发布"
      t.string   :display, default: "hide"
      t.datetime :profit_date
      t.string   :address
      t.string   :usage
      t.text     :usage_detail
      t.string   :credit_level
      t.datetime :principal_date
      t.integer  :status, default: 0
      t.integer :min_limit, :default => 1000
      t.integer :max_limit, :default => 100000
      t.integer :each_repayment_period, :default => 30
      t.boolean :locked, :default => false

      t.timestamps
    end
  end
end
