class AddUserToTimeEntries < ActiveRecord::Migration
  def up
  	add_column :time_entries, :user_id, :integer, :null => false
  	remove_column :time_entries, :employee_id
  	add_column :non_billable_entries, :user_id, :integer, :null => false
  	remove_column :non_billable_entries, :employee_id
  end

  def down
  	add_column :time_entries, :employee_id, :integer, :null => false
  	remove_column :time_entries, :user_id
  	add_column :non_billable_entries, :employee_id, :integer, :null => false
  	remove_column :non_billable_entries, :user_id
  end
end
