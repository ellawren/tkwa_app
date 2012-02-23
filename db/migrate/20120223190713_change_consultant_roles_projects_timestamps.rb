class ChangeConsultantRolesProjectsTimestamps < ActiveRecord::Migration
  def up
  	change_column :consultant_roles_projects, :created_at, :datetime, :null => true, :default => nil
    change_column :consultant_roles_projects, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :consultant_roles_projects, :created_at, :datetime
    change_column :consultant_roles_projects, :updated_at, :datetime
  end
end
