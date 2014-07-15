class AddOwnernumToFixeddep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :owner_num, :integer, :default =>0
  end
end
