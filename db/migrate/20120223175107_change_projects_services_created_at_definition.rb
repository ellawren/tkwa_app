class ChangeProjectsServicesCreatedAtDefinition < ActiveRecord::Migration
  def up
  	change_column :projects_services, :created_at, :datetime, :null => true, :default => nil
  	change_column :projects_services, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :projects_services, :created_at, :datetime
  	change_column :projects_services, :updated_at, :datetime
  end
end
