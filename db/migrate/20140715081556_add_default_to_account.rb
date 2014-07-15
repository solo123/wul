class AddDefaultToAccount < ActiveRecord::Migration
  def change
    change_column :accounts, :useable_balance, :decimal, :default=>0
    change_column :accounts, :balance, :decimal,:default=>0
    change_column :accounts, :frozen_balance, :decimal, :default=>0
    change_column :accounts, :total_estate, :decimal, :default=>0
  end
end
