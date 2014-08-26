class AddEmailcodeToVerify < ActiveRecord::Migration
  def change
    add_column :verifications, :email_code, :string
  end
end
