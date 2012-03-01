class DropTeamsTable < ActiveRecord::Migration
  def up
  	drop_table :teams
  end

  def down
  	create_table :teams do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end
end
