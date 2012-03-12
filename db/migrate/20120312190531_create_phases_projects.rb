class CreatePhasesProjects < ActiveRecord::Migration
  def change
      create_table :phases_projects, :id => false do |t|
      t.references :project, :null => false
      t.references :phase, :null => false

      t.timestamps
    end
    add_index :phases_projects, [:project_id, :phase_id], :unique => true
  end
end
