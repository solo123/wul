class ChangeVerificodeDefault < ActiveRecord::Migration
  def change
    change_column :verifications, :securyscore, :integer, :default => 0
  end
end
