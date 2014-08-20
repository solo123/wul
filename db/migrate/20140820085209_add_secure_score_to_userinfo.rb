class AddSecureScoreToUserinfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :secury_score, :integer, :default => 0
  end
end
