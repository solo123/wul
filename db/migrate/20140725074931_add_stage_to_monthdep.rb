class AddStageToMonthdep < ActiveRecord::Migration
  def change
    add_column :month_deposits, :stage, :string, :default => "未发布"
  end
end
