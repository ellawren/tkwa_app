class RenameConsProjectsTable < ActiveRecord::Migration
  def up
  	rename_table :cons_projects, :consultant_roles_projects
  end

  def down
  	rename_table :consultant_roles_projects, :cons_projects
  end
end
