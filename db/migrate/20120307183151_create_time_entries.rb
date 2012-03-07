class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.references :timesheet
      t.references :project
      t.date :date
      t.decimal :hours, :precision => 6, :scale => 2
      t.string :phase
      t.string :task

      t.timestamps
    end
  end
end
