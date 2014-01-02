class AddWeekColumnsToDataRecords < ActiveRecord::Migration
  def change
  	add_column :data_records, :start_week, :integer
  	add_column :data_records, :end_week, :integer
  	remove_column :data_records, :week
  end
end
