class AddPricipleDateToMonthdep < ActiveRecord::Migration
  def change
    add_column :month_deposits, :principal_date, :datetime
  end
end
