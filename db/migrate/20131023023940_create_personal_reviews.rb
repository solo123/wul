class CreatePersonalReviews < ActiveRecord::Migration
  def change
    create_table :personal_reviews do |t|
      t.integer :user_info_id
      t.date :id_card_verify_date
      t.date :credit_report_date
      t.date :work_verify_date
      t.date :income_verify_date
      t.integer :guarantee_institution_id

      t.timestamps
    end
  end
end
