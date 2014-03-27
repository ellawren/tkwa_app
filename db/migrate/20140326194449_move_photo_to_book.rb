class MovePhotoToBook < ActiveRecord::Migration
  def change
  	add_attachment :books, :photo
  	remove_attachment :recommendations, :photo
  end
end
