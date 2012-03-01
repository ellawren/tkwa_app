class AddRoleToEmployeeTeams < ActiveRecord::Migration
  def change
  	add_column :employee_teams, :role, :string
  end
end
