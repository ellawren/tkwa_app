class CreateNonBillableEntries < ActiveRecord::Migration
  def change
    create_table :non_billable_entries do |t|
      t.integer :timesheet_id
      t.integer :employee_id
      t.string :category
      t.string :description

      t.decimal :day1, :precision => 4, :scale => 2
      t.decimal :day2, :precision => 4, :scale => 2
      t.decimal :day3, :precision => 4, :scale => 2
      t.decimal :day4, :precision => 4, :scale => 2
      t.decimal :day5, :precision => 4, :scale => 2
      t.decimal :day6, :precision => 4, :scale => 2
      t.decimal :day7, :precision => 4, :scale => 2

      t.timestamps
    end
  end
end
