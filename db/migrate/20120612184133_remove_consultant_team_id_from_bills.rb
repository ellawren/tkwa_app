class RemoveConsultantTeamIdFromBills < ActiveRecord::Migration
  def up
  	remove_column :bills, :consultant_team_id
  end

  def down
  	add_column  :bills, :consultant_team_id, :integer, :null => false
  end
end
