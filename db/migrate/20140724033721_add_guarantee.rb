class AddGuarantee < ActiveRecord::Migration
  def change
    add_column :month_deposits, :guarantee, :string
  end
end
