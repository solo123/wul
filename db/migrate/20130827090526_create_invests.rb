class CreateInvests < ActiveRecord::Migration
  def change
    create_table :invests do |t|
			t.belongs_to :user_info
      t.string :loan_number
      t.string :transaction_number
			t.string :address
			t.string :usage
			t.text :usage_detail
			t.string :credit_level
			t.decimal :annual_rate, precision: 5, scale: 2, default:0
			t.decimal :amount, precision: 12, scale: 2, default: 0
			t.integer :repayment_period
			t.string :repayment_method
			t.decimal :each_repayment_amount, precision: 12, scale: 2
			t.decimal :free_invest_amount, precision: 12, scale: 2
			t.datetime :invest_end_date
			t.string :remark
			t.integer :status, default: 0
      t.string :invest_type, default: 'fixed'
      t.boolean :onsale, default: false
      t.decimal :discount_rate, default: 0.0
      t.integer :asset_id
      t.decimal :resell_price
      t.datetime :profit_date
      t.datetime :principle_date
      t.integer :product_id
      t.string :stage, :default => "normal"
      t.decimal :current_principal, precision: 12, scale: 2, default: 0
      t.string :owner_name, default: ""

      t.timestamps
    end
    add_index :invests, :asset_id, :unique => true
  end
end
