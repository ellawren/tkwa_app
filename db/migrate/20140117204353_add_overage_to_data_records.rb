class AddOverageToDataRecords < ActiveRecord::Migration
  def change
  	add_column :data_records, :overage_from_prev, :decimal, :precision => 6, :scale => 2
  end
end
