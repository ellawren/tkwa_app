class RemoveContactIdFromEmployeeTeam < ActiveRecord::Migration
  def up
  	remove_column :employee_teams, :contact_id
  end

  def down
  	add_column :employee_teams, :contact_id, :integer
  end
end
