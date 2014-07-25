class AddExpDateToMonth < ActiveRecord::Migration
  def change
    add_column :month_deposits, :expiring_date, :datetime
  end
end
