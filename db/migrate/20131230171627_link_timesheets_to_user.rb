class LinkTimesheetsToUser < ActiveRecord::Migration
  def up
  	add_column :timesheets, :user_id, :integer, :null => false
  	remove_column :timesheets, :employee_id
  end

  def down
  	add_column :timesheets, :employee_id, :integer, :null => false
  	remove_column :timesheets, :user_id
  end
end
