class AddBillablePerWeekToDataRecord < ActiveRecord::Migration
  def change
  	add_column :data_records, :billable_per_week, :decimal, :precision => 4, :scale => 2
  end
end
