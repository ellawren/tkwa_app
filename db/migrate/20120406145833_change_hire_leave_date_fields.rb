class ChangeHireLeaveDateFields < ActiveRecord::Migration
  def up
  	change_column :employees, :hire_date, :string
  	change_column :employees, :leave_date, :string
  end

  def down
  	change_column :employees, :hire_date, :date
  	change_column :employees, :leave_date, :date
  end
end
