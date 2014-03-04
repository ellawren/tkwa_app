class AddDataRecordIdToTimesheet < ActiveRecord::Migration
  def change
  	add_column :timesheets, :data_record_id, :integer
  end
end
