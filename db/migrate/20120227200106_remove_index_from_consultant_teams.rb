class RemoveIndexFromConsultantTeams < ActiveRecord::Migration
  def up
  	remove_index(:consultant_teams, :name => "index_consultant_teams_on_project_id_and_consultant_id")
  end

  def down
    add_index :consultant_teams, [:project_id, :consultant_id], :unique => true
  end
end
