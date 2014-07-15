class CreatePersonalFinances < ActiveRecord::Migration
  def change
    create_table :personal_finances do |t|
      t.integer :user_info_id
      t.decimal :monthly_income, precision: 12, scale: 2
      t.decimal :dpi, precision: 12, scale: 2
      t.decimal :pcdi, precision: 12, scale: 2

      t.timestamps
    end
  end
end
