class CreateEmployeesTimesheets < ActiveRecord::Migration
  def change
    create_table :employees_timesheets do |t|
      t.integer :employee_id
      t.integer :timesheet_id

      t.timestamps
    end
    add_index :employees_timesheets, :employee_id
    add_index :employees_timesheets, :timesheet_id
    add_index :employees_timesheets, [:employee_id, :timesheet_id], :unique => true
  end
end
