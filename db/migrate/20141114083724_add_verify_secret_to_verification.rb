class AddVerifySecretToVerification < ActiveRecord::Migration
  def change
    add_column :verifications, :verify_secret, :string, :default => ""
  end
end
