class CreateTimesheetsAgain < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.integer :year, :null => false
      t.integer :week, :null => false
      t.references :employee, :null => false

      t.timestamps
    end
    add_index :timesheets, [:employee_id, :year, :week], unique: true
  end
end
