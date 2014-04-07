class CreateUnassignedHours < ActiveRecord::Migration
  def change
    create_table :unassigned_hours do |t|
      t.integer :hours
      t.integer :project_id
      t.integer :year
      t.integer :week

      t.timestamps
    end
  end
end
