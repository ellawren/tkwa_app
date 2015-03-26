class AddBrgTargetToDataRecords < ActiveRecord::Migration
  def change
  	add_column :data_records, :brg_target, :decimal, :precision => 6, :scale => 2
  end
end
