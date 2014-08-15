class AddProfitDateToFixeddep < ActiveRecord::Migration
  def change
    add_column :fixed_deposits, :profit_rate, :datetime
  end
end
