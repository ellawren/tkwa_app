class DeleteVacationFromDataRecords < ActiveRecord::Migration
  def up
  	remove_column :data_records, :vacation
  	remove_column :data_records, :vacation_rollover
  end

  def down
  	add_column :data_records, :vacation, :decimal, :precision => 6, :scale => 2
  	add_column :data_records, :vacation_rollover, :decimal, :precision => 5, :scale => 2
  end
end
