class DropProjectTasksTable < ActiveRecord::Migration
  def up
  	drop_table :project_tasks
  end

  def down
  	create_table :project_tasks do |t|
      t.string :name
      t.integer :project_id

      t.timestamps
    end
  end
end
