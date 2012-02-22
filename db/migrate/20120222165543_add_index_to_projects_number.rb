class AddIndexToProjectsNumber < ActiveRecord::Migration
  def change
  	add_index :projects, :number, unique: true
  end
end
