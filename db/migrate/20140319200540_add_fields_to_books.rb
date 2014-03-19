class AddFieldsToBooks < ActiveRecord::Migration
  def change
  	change_column :books, :description, :string
  	add_column :books, :date, :string
  	add_column :books, :categories, :text
  end
end
