class CreateProductPrincipals < ActiveRecord::Migration
  def change
    create_table :product_principals do |t|
      t.integer :product_id
      t.datetime :refund_time
      t.decimal :refund_amount
      t.timestamps
    end
  end
end
