class ChangeHireLeaveColumnTypes < ActiveRecord::Migration
  def up
    change_column :employees, :hire_date, :date
    change_column :employees, :leave_date, :date
  end

  def down
    change_column :employees, :hire_date, :datetime
    change_column :employees, :leave_date, :datetime
  end
end
