class AddTimeEntriesIndex < ActiveRecord::Migration
  def change
  	add_index :time_entries, [:user_id, :timesheet_id]
  	add_index :time_entries, [:project_id, :phase_number]
  	add_index :time_entries, [:project_id]
  end
end
