class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :product_type
      t.string :product_name
      t.decimal :product_value
      t.integer :product_id
      t.integer :user_info_id
      t.timestamps
    end
  end
end
