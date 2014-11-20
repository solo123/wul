class CreateAccountOperations < ActiveRecord::Migration
  def change
    create_table :account_operations do |t|
      t.string :op_action
      t.string :op_name
      t.string :operator
      t.string :user_id
      t.boolean :op_result, :default => false
      t.integer :op_result_code, :integer, :default => 0
      t.decimal :op_amount
      t.integer :op_asset_id
      t.decimal :op_result_value
      t.integer :user_info_id
      t.integer :uinfo_id
      t.integer :op_account_id
      t.string :op_resource_name
      t.integer :op_resource_id
      t.string :operation_id

      t.decimal :op_result_value2
      t.decimal :uinfo_id2

      t.timestamps
    end
  end
end
