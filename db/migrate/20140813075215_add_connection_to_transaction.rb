class AddConnectionToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :user_info_id, :integer
    add_column :transactions, :invest_id, :integer
  end
end
