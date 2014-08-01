class AddDisplayToMonthdep < ActiveRecord::Migration
  def change
    add_column :month_deposits, :display, :string, :default => "hide"
  end
end
