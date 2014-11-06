class ChangeConsultantRolesTimestamps < ActiveRecord::Migration
  def up
  	change_column :consultants_consultant_roles, :created_at, :datetime, :null => true, :default => nil
    change_column :consultants_consultant_roles, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :consultants_consultant_roles, :created_at, :datetime
    change_column :consultants_consultant_roles, :updated_at, :datetime
  end
end