class AddHoursInWeekToDataRecords < ActiveRecord::Migration
  def change
  	add_column :data_records, :hours_in_week, :decimal, :precision => 4, :scale => 2
  end
end
