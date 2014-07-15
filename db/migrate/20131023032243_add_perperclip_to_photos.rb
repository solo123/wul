class AddPerperclipToPhotos < ActiveRecord::Migration
  def up
    add_attachment :photos, :pic
  end

  def down
    remove_attachment :photos, :pic
  end
end
