class AddProfitDateToFixed < ActiveRecord::Migration
  def change
    add_column :month_deposits, :profit_date, :datetime
  end
end
