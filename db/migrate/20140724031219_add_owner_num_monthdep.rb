class AddOwnerNumMonthdep < ActiveRecord::Migration
  def change
      add_column :month_deposits, :owner_num, :integer, :default => 0
  end
end
