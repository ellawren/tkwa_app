class ChangeContactToEmployee < ActiveRecord::Migration
  def up
  	add_column :employee_teams, :employee_id, :integer
  	add_index :employee_teams, [:employee_id], :unique => true, :name => "index_employee_teams_on_employee_id"
  end

  def down
  	remove_column :employee_teams, :employee_id
  end
end
