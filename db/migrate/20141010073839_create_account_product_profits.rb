class CreateAccountProductProfits < ActiveRecord::Migration
  def change
    create_table :account_product_profits do |t|
      t.integer :account_product_id
      t.datetime :refund_time
      t.decimal :refund_amount
      t.timestamps
    end
  end
end
