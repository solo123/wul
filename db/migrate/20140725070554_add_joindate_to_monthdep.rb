class AddJoindateToMonthdep < ActiveRecord::Migration
  def change
    add_column :month_deposits, :join_date, :datetime
  end
end
