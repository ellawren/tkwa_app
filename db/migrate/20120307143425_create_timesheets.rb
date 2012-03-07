class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.integer :year, :null => false
      t.integer :week, :null => false
      t.date :week_start
      t.date :week_end
      t.integer :employee_id, :null => false

      t.timestamps
    end
    add_index :timesheets, [:employee_id, :year, :week], unique: true
  end
end
