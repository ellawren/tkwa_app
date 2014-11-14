class AddNonBillableFieldsToDataRecords < ActiveRecord::Migration
  def change
  	add_column :data_records, :stp_target, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :mtg_target, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :adm_target, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :cmp_target, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :edu_target, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :sus_target, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :mkp_target, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :mkg_target, :decimal, :precision => 6, :scale => 2
  end
end
