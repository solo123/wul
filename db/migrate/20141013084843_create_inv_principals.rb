class CreateInvPrincipals < ActiveRecord::Migration
  def change
    create_table :invest_principals do |t|
      t.integer :invest_id
      t.datetime :refund_time
      t.decimal :refund_amount
      t.timestamps
    end
  end
end
