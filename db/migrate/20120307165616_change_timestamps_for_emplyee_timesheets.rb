class ChangeTimestampsForEmplyeeTimesheets < ActiveRecord::Migration
  def up
  	change_column :employee_timesheets, :created_at, :datetime, :null => true, :default => nil
    change_column :employee_timesheets, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :employee_timesheets, :created_at, :datetime
    change_column :employee_timesheets, :updated_at, :datetime
  end
end
