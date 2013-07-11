class CreateConsultantRolesPotentialProjects < ActiveRecord::Migration
  def change
      create_table :consultant_roles_potential_projects, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :consultant_role, :null => false

      t.timestamps
    end
    add_index :consultant_roles_potential_projects, [:potential_project_id, :consultant_role_id], :unique => true, :name => "potential_consultants_index"
  end
end
