class CreatePlanEntries < ActiveRecord::Migration
  def change
    create_table :plan_entries do |t|
      t.references :employee, :null => false
      t.references :project, :null => false
      t.decimal :hours, :precision => 6, :scale => 2
      t.integer :year, :null => false
      t.integer :week, :null => false

      t.timestamps
    end
  end
end
