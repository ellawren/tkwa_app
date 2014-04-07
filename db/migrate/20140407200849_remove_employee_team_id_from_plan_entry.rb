class RemoveEmployeeTeamIdFromPlanEntry < ActiveRecord::Migration
  def up
  	remove_column :plan_entries, :employee_team_id
  end

  def down
  	add_column :plan_entries, :employee_team_id, :integer
  end
end
