class AddDisplayToFixdep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :display, :string, :default => "hide"
  end
end
