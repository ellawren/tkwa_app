class ChangeTimesheetIntegersToDecimals < ActiveRecord::Migration
  def change
  	change_column :timesheets, :total_hours_saved, :decimal, :precision => 5, :scale => 2
  	change_column :timesheets, :nb_total_hours_saved, :decimal, :precision => 5, :scale => 2
  	change_column :timesheets, :timesheet_total_saved, :decimal, :precision => 5, :scale => 2
  	change_column :timesheets, :vacation_hours_saved, :decimal, :precision => 5, :scale => 2
  end

end
