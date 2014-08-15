class AddTimesheetsIndex < ActiveRecord::Migration
  def change
  	add_index :timesheets, [:user_id, :year]
  	add_index :timesheets, [:user_id, :year, :week]
  end
end
