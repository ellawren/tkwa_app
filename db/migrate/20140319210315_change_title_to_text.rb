class ChangeTitleToText < ActiveRecord::Migration
  def change
  	change_column :books, :title, :text
  end
end
