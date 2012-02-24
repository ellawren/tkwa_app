class ChangeTeamsTimestamps < ActiveRecord::Migration
  def up
  	change_column :teams, :created_at, :datetime, :null => true, :default => nil
    change_column :teams, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :teams, :created_at, :datetime
    change_column :teams, :updated_at, :datetime
  end
end
