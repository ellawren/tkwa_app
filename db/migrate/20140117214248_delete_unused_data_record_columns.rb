class DeleteUnusedDataRecordColumns < ActiveRecord::Migration
  def up
  	remove_column :data_records, :admin_meeting
  	remove_column :data_records, :computer
  	remove_column :data_records, :education
  	remove_column :data_records, :marketing
  	remove_column :data_records, :staff_meeting
  	remove_column :data_records, :stdio_projects
  	remove_column :data_records, :research
  	remove_column :data_records, :rate
  end

  def down
  	add_column :data_records, :admin_meeting, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :computer, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :education, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :marketing, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :staff_meeting, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :stdio_projects, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :research, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :rate, :decimal, :precision => 6, :scale => 2
  end
end
