class AddProfitDateToFixdep < ActiveRecord::Migration
  def change
    add_column :invests, :profit_rate, :datetime
  end
end
