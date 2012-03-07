class AddTimesheetColumns < ActiveRecord::Migration
  def change
	  add_column :timesheets, :employee_id, :integer
	  add_column :timesheets, :project_id, :integer
  end
end
