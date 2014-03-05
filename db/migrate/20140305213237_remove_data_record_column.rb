class RemoveDataRecordColumn < ActiveRecord::Migration
  def up
  	remove_column :timesheets, :data_record_id
  end

  def down
  	add_column :timesheets, :data_record_id, :integer
  end
end
