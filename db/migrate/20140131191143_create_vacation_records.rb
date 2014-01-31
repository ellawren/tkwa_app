class CreateVacationRecords < ActiveRecord::Migration
  def change
    create_table :vacation_records do |t|
      t.integer :user_id
      t.integer :year
      t.decimal :hours, :precision => 6, :scale => 2
      t.decimal :rollover, :precision => 6, :scale => 2

      t.timestamps
    end
  end
end
