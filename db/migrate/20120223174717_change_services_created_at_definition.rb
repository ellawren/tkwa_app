class ChangeServicesCreatedAtDefinition < ActiveRecord::Migration
  def up
  	change_column :services, :created_at, :datetime, :null => true, :default => nil
  	change_column :services, :updated_at, :datetime, :null => true, :default => nil
  	change_column :reimbursables, :created_at, :datetime, :null => true, :default => nil
  	change_column :reimbursables, :updated_at, :datetime, :null => true, :default => nil
  	change_column :consultant_roles, :created_at, :datetime, :null => true, :default => nil
  	change_column :consultant_roles, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :services, :created_at, :datetime
  	change_column :services, :updated_at, :datetime
  	change_column :reimbursables, :created_at, :datetime
  	change_column :reimbursables, :updated_at, :datetime
  	change_column :consultant_roles, :created_at, :datetime
  	change_column :consultant_roles, :updated_at, :datetime
  end
end
