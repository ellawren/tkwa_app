class AddConsultantRoleIdToConsultantTeam < ActiveRecord::Migration
  def change
  	add_column :consultant_teams, :consultant_role_id, :integer
  end
end
