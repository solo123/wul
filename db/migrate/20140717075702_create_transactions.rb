class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :trans_type
      t.decimal :operation_amount, precision: 14, scale: 2, default:  0.00
      t.decimal :account_before,  precision: 14, scale: 2, default:  0.00
      t.decimal :account_after,  precision: 14, scale: 2, default:  0.00
      t.decimal :frozen_before, precision: 14, scale: 2, default:  0.00
      t.decimal :frozen_after, precision: 14, scale: 2, default:  0.00
      t.integer :user_info_id
      t.string :deposit_number
      t.string :product_type

      t.timestamps
    end
  end
end
