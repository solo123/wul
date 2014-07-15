class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title
      t.text :content
      t.integer :creator_id
      t.integer :approval_id
      t.datetime :release_time
      t.datetime :expiration_time
      t.integer :status

      t.timestamps
    end
  end
end
