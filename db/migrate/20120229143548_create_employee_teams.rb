class CreateEmployeeTeams < ActiveRecord::Migration
  def change
    create_table :employee_teams do |t|
	  t.integer :contact_id
      t.integer :project_id

      t.timestamps
    end
    add_index :employee_teams, :project_id
    add_index :employee_teams, :contact_id
    add_index :employee_teams, [:project_id, :contact_id], :unique => true
  end
end
