class AddBillableRateToDataRecords < ActiveRecord::Migration
  def up
  	add_column :data_records, :billable_rate, :decimal, :precision => 5, :scale => 2
  	remove_column :data_records, :billable
  end

  def down
  	remove_column :data_records, :billable_rate
	add_column :data_records, :billable, :precision => 6, :scale => 2
  end
end
