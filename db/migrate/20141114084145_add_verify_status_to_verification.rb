class AddVerifyStatusToVerification < ActiveRecord::Migration
  def change
    add_column :verifications, :email_change, :boolean, :default => false
    add_column :verifications, :mobile_change, :boolean, :default => false
    add_column :verifications, :question_change, :boolean, :default => false
  end
end
