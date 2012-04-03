class DropEmployeeInfoColumns < ActiveRecord::Migration
  def up
  	remove_column :employees, :week_hours
    remove_column :employees, :vacation_hours
    remove_column :employees, :holiday_hours
    remove_column :employees, :billable_goal
    remove_column :employees, :hourly
  end

  def down
  	add_column :employees, :week_hours, :decimal, :precision => 4, :scale => 2
    add_column :employees, :vacation_hours, :decimal, :precision => 6, :scale => 2
    add_column :employees, :holiday_hours, :decimal, :precision => 4, :scale => 2
    add_column :employees, :billable_goal, :decimal, :precision => 4, :scale => 2
    add_column :employees, :hourly, :decimal, :precision => 4, :scale => 2
  end
end
