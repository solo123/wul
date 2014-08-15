class RenameProfitDateToFixeddep < ActiveRecord::Migration
  def change
    rename_column :fixed_deposits, :profit_rate, :profit_date
  end
end
