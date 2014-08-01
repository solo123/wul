class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :deposit_number
      t.string :invest_type
      t.decimal :amount
      t.integer :user_id
      t.decimal :rate

      t.timestamps
    end
  end
end
