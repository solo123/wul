class CreateBankcards < ActiveRecord::Migration
  def change
    create_table :bankcards do |t|
      t.integer :user_id
      t.string :bankname
      t.string :cardid

      t.timestamps
    end
  end
end
