class ChangeTimesheetsColumns < ActiveRecord::Migration
  def change
  	remove_column :timesheets, :week_start
  	remove_column :timesheets, :week_end
  	remove_column :timesheets, :employee_id

  	add_column :timesheets, :hours, :decimal, :precision => 6, :scale => 2
  	add_column :timesheets, :phase, :string 
  	add_column :timesheets, :task, :string 
  end
end
