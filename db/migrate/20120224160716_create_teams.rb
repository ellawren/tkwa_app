class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
    add_index :teams, :project_id
    add_index :teams, :user_id
    add_index :teams, [:project_id, :user_id], :unique => true
  end
end
