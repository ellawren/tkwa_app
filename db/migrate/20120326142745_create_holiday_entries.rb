class CreateHolidayEntries < ActiveRecord::Migration
  def change
    create_table :holiday_entries do |t|
      t.integer :holiday_id
      t.integer :non_billable_entry_id

      t.timestamps
    end
    add_index :holiday_entries, [:holiday_id, :non_billable_entry_id], :unique => true
  end
end
