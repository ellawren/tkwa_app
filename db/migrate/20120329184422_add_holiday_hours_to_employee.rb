class AddHolidayHoursToEmployee < ActiveRecord::Migration
  def change
  	add_column :employees, :holiday_hours, :decimal,   :precision => 4, :scale => 2
  	change_column :employees, :vacation_hours, :decimal,   :precision => 6, :scale => 2
  end
end
