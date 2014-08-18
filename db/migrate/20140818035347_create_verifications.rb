class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.string :phone
      t.string :email
      t.datetime :phonetime
      t.string :personalid
      t.string :phonestatus
      t.string :emailstatus
      t.string :idstatus
      t.integer :securyscore
      t.integer :user_info_id
      t.string :verify_code

      t.timestamps
    end
  end
end
