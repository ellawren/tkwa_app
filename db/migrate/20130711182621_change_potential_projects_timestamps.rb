class ChangePotentialProjectsTimestamps < ActiveRecord::Migration
  def up
  	change_column :potential_projects_services, :created_at, :datetime, :null => true, :default => nil
    change_column :potential_projects_services, :updated_at, :datetime, :null => true, :default => nil
    change_column :potential_projects_reimbursables, :created_at, :datetime, :null => true, :default => nil
    change_column :potential_projects_reimbursables, :updated_at, :datetime, :null => true, :default => nil
    change_column :consultant_roles_potential_projects, :created_at, :datetime, :null => true, :default => nil
    change_column :consultant_roles_potential_projects, :updated_at, :datetime, :null => true, :default => nil
    change_column :phases_potential_projects, :created_at, :datetime, :null => true, :default => nil
    change_column :phases_potential_projects, :updated_at, :datetime, :null => true, :default => nil
    change_column :potential_projects_tasks, :created_at, :datetime, :null => true, :default => nil
    change_column :potential_projects_tasks, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :potential_projects_services, :created_at, :datetime
    change_column :potential_projects_services, :updated_at, :datetime
    change_column :potential_projects_reimbursables, :created_at, :datetime
    change_column :potential_projects_reimbursables, :updated_at, :datetime
    change_column :consultant_roles_potential_projects, :created_at, :datetime
    change_column :consultant_roles_potential_projects, :updated_at, :datetime
    change_column :phases_potential_projects, :created_at, :datetime
    change_column :phases_potential_projects, :updated_at, :datetime
    change_column :potential_projects_tasks, :created_at, :datetime
    change_column :potential_projects_tasks, :updated_at, :datetime
  end
end
