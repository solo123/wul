class AddStageToFixeddep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :stage, :string, :default => "未发布"
  end
end
