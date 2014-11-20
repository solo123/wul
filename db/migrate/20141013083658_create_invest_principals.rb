class CreateInvestPrincipals < ActiveRecord::Migration
  def change
    create_table :account_invest_principals do |t|
      t.integer :account_sub_invest_id
      t.datetime :refund_time
      t.decimal :refund_amount
      t.timestamps
    end
  end
end
