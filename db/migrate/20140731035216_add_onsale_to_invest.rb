class AddOnsaleToInvest < ActiveRecord::Migration
  def change
    add_column :invests, :onsale, :boolean, :default => false
  end
end
