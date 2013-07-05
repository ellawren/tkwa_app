class AddConsultantTeamIdToBills < ActiveRecord::Migration
  def change
  	add_column  :bills, :consultant_team_id, :integer, :null => false
  end
end
