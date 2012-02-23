class ChangeScopeDataTypes < ActiveRecord::Migration
  def up
  	change_column :projects, :services_provided, :text
  	change_column :projects, :reimbursables, :text
  	change_column :projects, :consultant_roles, :text
  end

  def down
  	change_column :projects, :number, :string
  	change_column :projects, :reimbursables, :string
  	change_column :projects, :consultant_roles, :string
  end
end
