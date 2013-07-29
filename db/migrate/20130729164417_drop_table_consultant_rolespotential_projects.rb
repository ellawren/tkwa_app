class DropTableConsultantRolespotentialProjects < ActiveRecord::Migration
  def up
  	drop_table :consultant_roles_potential_projects
  end

  def down
  	 create_table :consultant_roles_potential_projects, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :consultant_role, :null => false

      t.timestamps
    end
  end
end
