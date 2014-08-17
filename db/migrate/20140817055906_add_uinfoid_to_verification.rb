class AddUinfoidToVerification < ActiveRecord::Migration
  def change
    add_column :verifications, :user_info_id, :integer
  end
end
