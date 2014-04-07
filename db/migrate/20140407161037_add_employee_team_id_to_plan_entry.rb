class AddEmployeeTeamIdToPlanEntry < ActiveRecord::Migration
  def change
  	add_column :plan_entries, :employee_team_id, :integer
  end
end
