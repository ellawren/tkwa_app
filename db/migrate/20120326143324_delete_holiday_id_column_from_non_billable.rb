class DeleteHolidayIdColumnFromNonBillable < ActiveRecord::Migration
  def up
  	remove_column :non_billable_entries, :holiday_id
  end

  def down
  	add_column :non_billable_entries, :holiday_id, :integer
  end
end
