class AddStatusToTimesheets < ActiveRecord::Migration
  def change
  	add_column  :timesheets, :status, :string
  end
end
