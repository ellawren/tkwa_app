class AddConsultantIdToConsultantTeams < ActiveRecord::Migration
  def change
  	add_column :consultant_teams, :consultant_id, :integer
  end
end
