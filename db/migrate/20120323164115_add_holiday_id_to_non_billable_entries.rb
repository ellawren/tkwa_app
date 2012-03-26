class AddHolidayIdToNonBillableEntries < ActiveRecord::Migration
  def change
  	add_column :non_billable_entries, :holiday_id, :integer
  end
end
