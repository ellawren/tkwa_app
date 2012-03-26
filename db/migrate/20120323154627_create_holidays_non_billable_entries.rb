class CreateHolidaysNonBillableEntries < ActiveRecord::Migration
  def change
      create_table :holidays_non_billable_entries, :id => false do |t|
      t.references :holiday, :null => false
      t.references :non_billable_entry, :null => false

      t.timestamps
    end
  end
end
