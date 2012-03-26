class ChangeProjestsTasksTimestamps < ActiveRecord::Migration
  def up
    change_column :projects_tasks, :created_at, :datetime, :null => true, :default => nil
    change_column :projects_tasks, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
    change_column :projects_tasks, :created_at, :datetime
    change_column :projects_tasks, :updated_at, :datetime
  end
end
