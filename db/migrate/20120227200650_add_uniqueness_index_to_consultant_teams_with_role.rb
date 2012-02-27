class AddUniquenessIndexToConsultantTeamsWithRole < ActiveRecord::Migration
  def change
  	add_index :consultant_teams, [:project_id, :consultant_id, :consultant_role], :unique => true, :name => "index_consultant_teams_on_role_and_ids"
  end
end
