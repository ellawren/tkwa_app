class DropBillsConsultantTeamsJoinTable < ActiveRecord::Migration
  def up
  	drop_table :bills_consultant_teams
  end

  def down
      create_table :bills_consultant_teams, :id => false do |t|
      t.references :bill, :null => false
      t.references :consultant_team, :null => false

      t.timestamps
    end
    add_index :bills_consultant_teams, [:bill_id, :consultant_team_id], :unique => true
  end
end
