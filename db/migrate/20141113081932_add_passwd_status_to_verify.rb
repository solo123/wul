class AddPasswdStatusToVerify < ActiveRecord::Migration
  def change
    add_column :verifications, :passwordstatus, :string, :default => "confirming"
  end
end
