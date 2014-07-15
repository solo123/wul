class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_data_type
      t.integer :photo_data_id
      t.integer :creator_id

      t.timestamps
    end
  end
end
