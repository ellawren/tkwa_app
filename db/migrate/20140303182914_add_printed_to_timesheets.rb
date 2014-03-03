class AddPrintedToTimesheets < ActiveRecord::Migration
  def change
  	add_column :timesheets, :printed, :boolean, :default => false
  end
end
