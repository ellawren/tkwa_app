class RemoveScopeColumns < ActiveRecord::Migration
  def up
  	remove_column :projects, :services_provided
  	remove_column :projects, :reimbursables
  	remove_column :projects, :consultant_roles
  end

  def down
  	add_column :projects, :services_provided, :text
  	add_column :projects, :reimbursables, :text
  	add_column :projects, :consultant_roles, :text
  end
end
