class DeleteTimeTables < ActiveRecord::Migration
  def up
  	drop_table :employee_timesheets
  	drop_table :projects_timesheets
  	drop_table :timesheets
  end

  def down
  	create_table :employee_timesheets do |t|
      t.integer :employee_id
      t.integer :timesheet_id

      t.timestamps
    end

    create_table :projects_timesheets do |t|
      t.integer :project_id
      t.integer :timesheet_id

      t.timestamps
    end

    create_table :timesheets do |t|
      t.integer :year, :null => false
      t.integer :week, :null => false
      t.date :week_start
      t.date :week_end
      t.integer :employee_id, :null => false

      t.timestamps
    end
  end
end
