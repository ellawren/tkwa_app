class RemoveIdFromConsultantTeams < ActiveRecord::Migration
  def up
  	remove_column :consultant_teams, :consultant_id
  end

  def down
  	add_column :consultant_teams, :consultant_id, :integer
  end
end
