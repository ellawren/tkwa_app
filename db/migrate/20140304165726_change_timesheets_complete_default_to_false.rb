class ChangeTimesheetsCompleteDefaultToFalse < ActiveRecord::Migration
  def up
  	change_column :timesheets, :complete, :boolean, :default => false
  end

  def down
  	change_column :timesheets, :complete, :boolean, :default => true
  end
end
