class AddTotalsToTimesheets < ActiveRecord::Migration
  def change
  	add_column :timesheets, :total_hours_saved, :integer
  	add_column :timesheets, :nb_total_hours_saved, :integer
  	add_column :timesheets, :timesheet_total_saved, :integer
  	add_column :timesheets, :vacation_hours_saved, :integer
  end
end
