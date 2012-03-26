class DropHolidayEntriesTable < ActiveRecord::Migration
  def up
  	drop_table :holiday_entries
  end

  def down
  	create_table :holiday_entries do |t|
      t.integer :holiday_id
      t.integer :non_billable_entry_id

      t.timestamps
    end
  end
end
