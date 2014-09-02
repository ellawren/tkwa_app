class RemoveConsultantName < ActiveRecord::Migration
  def change
  	remove_column :consultant_teams, :consultant_name
  end
end
