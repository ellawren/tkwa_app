class AddNonBillableFieldsToDataRecord < ActiveRecord::Migration
  def change
  	add_column  :data_records, :admin_meeting, :decimal, :precision => 6, :scale => 2
  	add_column  :data_records, :computer, :decimal, :precision => 6, :scale => 2
  	add_column  :data_records, :education, :decimal, :precision => 6, :scale => 2
  	add_column  :data_records, :marketing, :decimal, :precision => 6, :scale => 2
  	add_column  :data_records, :staff_meeting, :decimal, :precision => 6, :scale => 2
  	add_column  :data_records, :stdio_projects, :decimal, :precision => 6, :scale => 2
  	add_column  :data_records, :research, :decimal, :precision => 6, :scale => 2
  end
end
