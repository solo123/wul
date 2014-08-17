class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.string :phone
      t.string :email
      t.datetime :phonetime
      t.string :idno
      t.string :phonestatus
      t.string :emailstatus
      t.string :idstatus
      t.integer :securyscore

      t.timestamps
    end
  end
end
