class ChangeTimesheetStatusDefault < ActiveRecord::Migration
  def change
  	change_column_default(:timesheets,:status,true)
  end
end
