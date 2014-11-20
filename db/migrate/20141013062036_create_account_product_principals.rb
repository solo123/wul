class CreateAccountProductPrincipals < ActiveRecord::Migration
  def change
    create_table :account_product_principals do |t|
      t.integer :account_product_id
      t.datetime :refund_time
      t.decimal :refund_amount, precision: 14, scale: 2, default: 0.00
      t.timestamps
    end
  end
end
