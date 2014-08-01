class AddDefaultStatusToFixeddep < ActiveRecord::Migration
  def change
    change_column :fixed_deposits, :status, :string, :default => "未发布"
  end
end
