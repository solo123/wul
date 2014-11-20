class AddInvestNumberToInvest < ActiveRecord::Migration
  def change
    add_column :invests, :invest_number, :string, :uniqueness => true
  end
end
