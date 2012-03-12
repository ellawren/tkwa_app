class ChangePhasesProjectsTimestamps < ActiveRecord::Migration
  def up
    change_column :phases_projects, :created_at, :datetime, :null => true, :default => nil
    change_column :phases_projects, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
    change_column :phases_projects, :created_at, :datetime
    change_column :phases_projects, :updated_at, :datetime
  end
end
