class CreateDataRecords < ActiveRecord::Migration
  def change
    create_table :data_records do |t|
      t.integer :year
      t.decimal :week, :precision => 4, :scale => 2
	  t.decimal :vacation, :precision => 6, :scale => 2
	  t.decimal :holiday, :precision => 4, :scale => 2
	  t.decimal :billable, :precision => 6, :scale => 2
	  t.decimal :rate, :precision => 6, :scale => 2

      t.timestamps
    end
  end
end
