class AddInvestType < ActiveRecord::Migration
  def change
    add_column :invests, :invest_type, :string, :default => "fixed"
  end
end
