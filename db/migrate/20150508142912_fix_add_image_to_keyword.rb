class FixAddImageToKeyword < ActiveRecord::Migration
  def self.up
    add_attachment :keywords, :image
    remove_attachment :users, :image
  end

  def self.down
    remove_attachment :keywords, :image
  end
end
