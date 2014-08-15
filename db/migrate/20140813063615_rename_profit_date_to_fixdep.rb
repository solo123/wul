class RenameProfitDateToFixdep < ActiveRecord::Migration
  def change
    rename_column :invests, :profit_rate, :profit_date
  end
end
