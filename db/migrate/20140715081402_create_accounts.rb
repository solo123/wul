class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.decimal :useable_balance
      t.decimal :balance
      t.decimal :frozen_balance
      t.decimal :total_estate

      t.timestamps
    end
  end
end
