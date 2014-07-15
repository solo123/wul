class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
			t.integer :user_id
      t.string :show_id
      t.string :gender
      t.integer :age
      t.date :birthday
      t.string :education
      t.string :education_from
      t.string :marital_status
      t.integer :childs_status
      t.string :domiciliary_reg
			t.string :real_name
			t.string :id_card_number
			t.string :mobile
			t.datetime :id_card_verify_date
			t.datetime :mobile_verify_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
