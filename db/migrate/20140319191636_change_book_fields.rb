class ChangeBookFields < ActiveRecord::Migration
  def up
  	remove_column :books, :subjects
  	remove_column :books, :category
  	add_column :books, :description, :text
  end

  def down
  	add_column :books, :subjects, :text
  	add_column :books, :category, :integer
  	remove_column :books, :description
  end
end
