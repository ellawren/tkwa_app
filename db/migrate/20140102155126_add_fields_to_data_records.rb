class AddFieldsToDataRecords < ActiveRecord::Migration
  def change
  	add_column :data_records, :pay_type, :string, :default => "Salary"
  	add_column :data_records, :start_date, :string
  	add_column :data_records, :end_date, :string
  	add_column :data_records, :vacation_rollover, :decimal, :precision => 5, :scale => 2
  end
end
