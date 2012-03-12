class AddEmployeeIdIndexToTimeEntries < ActiveRecord::Migration
  def change
  	add_index :time_entries, [:employee_id, :phase]
  end
end
