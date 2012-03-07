class RenameEmployeesTimesheetsTable < ActiveRecord::Migration
  def up
  	rename_table :employees_timesheets, :employee_timesheets
  end

  def down
  	rename_table :employee_timesheets, :employees_timesheets
  end
end
