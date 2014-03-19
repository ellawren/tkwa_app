class ChangeBookTypeDefault < ActiveRecord::Migration
  def change
  	change_column :books, :status, :string, :default => "On Shelves"
  	change_column :books, :type, :string, :default => "Book"
  end
end
