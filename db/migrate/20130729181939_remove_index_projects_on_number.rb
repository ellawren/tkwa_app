class RemoveIndexProjectsOnNumber < ActiveRecord::Migration
  def up
  	remove_index "projects", :name => "index_projects_on_number"
  end

  def down
  	add_index "projects", ["number"], :name => "index_projects_on_number", :unique => true
  end
end
