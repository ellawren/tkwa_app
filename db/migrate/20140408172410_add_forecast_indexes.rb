class AddForecastIndexes < ActiveRecord::Migration
  def change
  	add_index :available_hours, :user_id, :name => 'available_hours_user_id'
  	add_index :non_billable_hours, :user_id, :name => 'non_billable_hours_user_id'
  	add_index :unassigned_hours, :project_id, :name => 'unassigned_hours_project_id'
  	add_index :plan_entries, :project_id, :name => 'plan_entries_project_id'
  	add_index :plan_entries, :user_id, :name => 'plan_entries_user_id'
  	add_index :plan_entries, :employee_team_id, :name => 'plan_entries_employee_team_id'
  end
end
