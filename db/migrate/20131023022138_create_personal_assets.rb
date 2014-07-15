class CreatePersonalAssets < ActiveRecord::Migration
  def change
    create_table :personal_assets do |t|
			t.integer :user_info_id
      t.string :house_property
      t.string :housing_loan
      t.string :purchase_date
      t.string :car_property

      t.timestamps
    end
  end
end
