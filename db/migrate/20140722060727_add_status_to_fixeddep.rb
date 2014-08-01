class AddStatusToFixeddep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :status, :string
  end
end
