class AddScopeToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :services_provided, :string
  	add_column :projects, :reimbursables, :string
  	add_column :projects, :consultant_roles, :string
  end
end
