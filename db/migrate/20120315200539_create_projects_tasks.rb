class CreateProjectsTasks < ActiveRecord::Migration
  def change
      create_table :projects_tasks, :id => false do |t|
      t.references :project, :null => false
      t.references :task, :null => false

      t.timestamps
    end
    add_index :projects_tasks, [:project_id, :task_id], :unique => true
  end
end
