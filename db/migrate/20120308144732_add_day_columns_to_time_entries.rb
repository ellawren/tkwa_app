class AddDayColumnsToTimeEntries < ActiveRecord::Migration
  def change
  	add_column :time_entries, :day1, :decimal, :precision => 4, :scale => 2
  	add_column :time_entries, :day2, :decimal, :precision => 4, :scale => 2
  	add_column :time_entries, :day3, :decimal, :precision => 4, :scale => 2
  	add_column :time_entries, :day4, :decimal, :precision => 4, :scale => 2
  	add_column :time_entries, :day5, :decimal, :precision => 4, :scale => 2
  	add_column :time_entries, :day6, :decimal, :precision => 4, :scale => 2
  	add_column :time_entries, :day7, :decimal, :precision => 4, :scale => 2
  end
end
