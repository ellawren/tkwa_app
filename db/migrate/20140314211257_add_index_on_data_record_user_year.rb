class AddIndexOnDataRecordUserYear < ActiveRecord::Migration
  def up
  	add_index :data_records, [:user_id, :year], :unique => true
  end

  def down
  	remove_index :data_records, [:user_id, :year]
  end
end
