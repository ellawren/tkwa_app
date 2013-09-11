class ChangeEmployeeTeamsIndexes < ActiveRecord::Migration
  def up
  	remove_index :employee_teams, :name => "index_employee_teams_on_employee_id"
  end

  def down
  	add_index :employee_teams, [:employee_id], :unique => true, :name => "index_employee_teams_on_employee_id"
  end
end
