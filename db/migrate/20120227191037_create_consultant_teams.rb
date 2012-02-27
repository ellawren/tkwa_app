class CreateConsultantTeams < ActiveRecord::Migration
  def change
    create_table :consultant_teams do |t|
      t.integer :project_id
      t.integer :consultant_id

      t.timestamps
    end
    add_index :consultant_teams, :project_id
    add_index :consultant_teams, :consultant_id
    add_index :consultant_teams, [:project_id, :consultant_id], :unique => true
  end
end
