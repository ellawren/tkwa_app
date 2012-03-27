class AddEmployeeHoursFields < ActiveRecord::Migration
  def change
	  add_column :employees, :week_hours, :decimal,   :precision => 4, :scale => 2
	  add_column :employees, :vacation_hours, :decimal,   :precision => 4, :scale => 2
  end
end
