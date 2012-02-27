class AddRoleToConsultantTeams < ActiveRecord::Migration
  def change
  	add_column :consultant_teams, :consultant_role, :string
  end
end
