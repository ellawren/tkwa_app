class LinkEmployeeTeamsToUser < ActiveRecord::Migration
  def up
  	add_column :employee_teams, :user_id, :integer
  	remove_column :employee_teams, :employee_id
  end

  def down
  	remove_column :employee_teams, :user_id
  	add_column :employee_teams, :employee_id, :integer
  end
end
