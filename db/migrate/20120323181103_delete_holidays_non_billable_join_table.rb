class DeleteHolidaysNonBillableJoinTable < ActiveRecord::Migration
  def up
  	drop_table :holidays_non_billable_entries
  end

  def down
      create_table :holidays_non_billable_entries, :id => false do |t|
      t.references :holiday, :null => false
      t.references :non_billable_entry, :null => false
      t.timestamps
  end
  end
end
