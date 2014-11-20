class CreateMessagesTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.string :creator
      t.integer :approval_id
      t.integer :user_info_id
      t.datetime :release_time
      t.datetime :expiration_time
      t.integer :status, :default => 0
      t.timestamps
    end
  end
end
