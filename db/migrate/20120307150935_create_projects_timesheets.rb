class CreateProjectsTimesheets < ActiveRecord::Migration
  def change
    create_table :projects_timesheets do |t|
      t.integer :project_id
      t.integer :timesheet_id

      t.timestamps
    end
    add_index :projects_timesheets, :project_id
    add_index :projects_timesheets, :timesheet_id
    add_index :projects_timesheets, [:project_id, :timesheet_id], :unique => true
  end
end
