class AddVericodeToVerification < ActiveRecord::Migration
  def change
    add_column :verifications, :verify_code, :string
  end
end
