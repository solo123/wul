class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.string :phone
      t.string :email
      t.datetime :phonetime
      t.string :personalid
      t.string :phonestatus, :default => "confirming"
      t.string :emailstatus, :default => "confirming"
      t.string :idstatus, :default => "confirming"
      t.integer :securyscore, :default => 0
      t.integer :user_info_id
      t.string :verify_code
      t.boolean :phone_confirm_status, :default => false
      t.string :realname
      t.string :email_code
      t.string :passwd

      t.timestamps
    end
  end
end
