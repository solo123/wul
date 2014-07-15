class CreatePersonalCredits < ActiveRecord::Migration
  def change
    create_table :personal_credits do |t|
			t.integer :user_info_id
      t.string :other_credit
      t.string :credit_cards
      t.string :credit_utilization_rate

      t.timestamps
    end
  end
end
