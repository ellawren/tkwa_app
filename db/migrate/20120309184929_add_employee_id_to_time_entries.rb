class AddEmployeeIdToTimeEntries < ActiveRecord::Migration
  def change
  	add_column :time_entries, :employee_id, :integer
  end
end
