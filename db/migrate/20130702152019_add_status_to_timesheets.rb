class AddStatusToTimesheets < ActiveRecord::Migration
  def change
  	add_column  :timesheets, :status, :boolean
  end
end
