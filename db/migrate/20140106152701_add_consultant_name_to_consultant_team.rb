class AddConsultantNameToConsultantTeam < ActiveRecord::Migration
  def change
  	add_column :consultant_teams, :consultant_name, :string
  end
end
