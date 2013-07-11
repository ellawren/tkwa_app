class CreatePhasesPotentialProjects < ActiveRecord::Migration
  def change
      create_table :phases_potential_projects, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :phase, :null => false

      t.timestamps
    end
    add_index :phases_potential_projects, [:potential_project_id, :phase_id], :unique => true, :name => "potential_phases_index"
  end
end
