class CreatePotentialProjectsTasks < ActiveRecord::Migration
  def change
      create_table :potential_projects_tasks, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :task, :null => false

      t.timestamps
    end
    add_index :potential_projects_tasks, [:potential_project_id, :task_id], :unique => true, :name => "potential_tasks_index"
  end
end
