class RemoveDataRecordDateColumns < ActiveRecord::Migration
  def up
  	remove_column :data_records, :start_date
  	remove_column :data_records, :end_date
  end

  def down
  	add_column :data_records, :start_date, :string
  	add_column :data_records, :end_date, :string
  end
end
