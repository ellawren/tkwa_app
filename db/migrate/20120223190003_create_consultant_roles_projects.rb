class CreateConsultantRolesProjects < ActiveRecord::Migration
  def change
      create_table :consultant_roles_projects, :id => false do |t|
      t.references :project, :null => false
      t.references :consultant_role, :null => false

      t.timestamps
    end
  end
end
