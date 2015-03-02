class AddCommunityServiceToDataRecords < ActiveRecord::Migration
  def change
  	add_column :data_records, :com_target, :decimal, :precision => 6, :scale => 2
  end
end
