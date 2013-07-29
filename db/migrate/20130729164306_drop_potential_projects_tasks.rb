class DropPotentialProjectsTasks < ActiveRecord::Migration
  def up
  	drop_table :potential_projects_tasks
  end

  def down
  	create_table :potential_projects_tasks, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :task, :null => false

      t.timestamps
    end
  end
end
