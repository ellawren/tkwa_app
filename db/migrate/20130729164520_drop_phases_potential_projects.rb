class DropPhasesPotentialProjects < ActiveRecord::Migration
  def up
  	drop_table :phases_potential_projects
  end

  def down
  	create_table :phases_potential_projects, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :phase, :null => false

      t.timestamps
    end
  end
end
