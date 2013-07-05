class ChangeBillsConsultantTeamsTimestamps < ActiveRecord::Migration
  def up
    change_column :bills_consultant_teams, :created_at, :datetime, :null => true, :default => nil
    change_column :bills_consultant_teams, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
    change_column :bills_consultant_teams, :created_at, :datetime
    change_column :bills_consultant_teams, :updated_at, :datetime
  end
end
