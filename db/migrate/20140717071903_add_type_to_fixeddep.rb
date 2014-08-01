class AddTypeToFixeddep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :product_type, :string, :default => 'fixed'
  end
end
