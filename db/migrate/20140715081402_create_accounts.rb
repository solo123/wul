class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.decimal :useable_balance, default: 0.0, precision: 14, scale: 2
      t.decimal :balance, default: 0.0, precision: 14, scale: 2
      t.decimal :frozen_balance, default: 0.0, precision: 14, scale: 2
      t.decimal :total_estate, default: 0.0, precision: 14, scale: 2
      t.integer :user_info_id
      t.timestamps
    end
  end
end
