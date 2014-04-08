class AddMissingIndexes < ActiveRecord::Migration
  def change
  	add_index :recommendations, [:book_id, :user_id], :name => 'index_recommendations_on_book_id_and_user_id'
  	add_index :actuals, :project_id, :name => 'index_actuals_on_project_id'
  	add_index :non_billable_entries, [:timesheet_id, :user_id], :name => 'index_nb_entries_on_timesheet_id_and_user_id'
  	add_index :books, :subject_id, :name => 'index_books_on_subject_id'
  	add_index :messages, [:user_id, :project_id], :name => 'index_messages_on_user_id_and_project_id'
  	add_index :vacations, :user_id, :name => 'index_vacations_on_user_id'
  	add_index :expense_reports, [:user_id, :project_id], :name => 'index_expense_reports_on_user_id_and_project_id'
  	add_index :vacation_records, :user_id, :name => 'index_vacation_records_on_user_id'
  	add_index :patterns, :project_id, :name => 'index_patterns_on_project_id'
  	add_index :schedule_items, [:project_id, :phase_id], :name => 'index_schedule_items_on_project_id_and_phase_id'
  	add_index :shop_drawings, [:project_id, :consultant_id], :name => 'index_shop_drawings_on_project_id_and_consultant_id'
  	add_index :contacts, :company_id, :name => 'index_contacts_on_company_id'
  	add_index :bills, :consultant_team_id, :name => 'index_bills_on_consultant_team_id'
  	add_index :employee_teams, :user_id, :name => 'index_employee_teams_on_user_id'
  	add_index :timesheets, :user_id, :name => 'index_timesheets_on_user_id'
  	add_index :time_entries, [:timesheet_id, :project_id, :user_id], :name => 'index_time_entries_on_timesheet_project_and_user'
  	add_index :tasks, :project_id, :name => 'index_tasks_on_project_id'
  end
end
