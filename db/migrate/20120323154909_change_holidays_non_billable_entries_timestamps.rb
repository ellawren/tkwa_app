class ChangeHolidaysNonBillableEntriesTimestamps < ActiveRecord::Migration
  def up
    change_column :holidays_non_billable_entries, :created_at, :datetime, :null => true, :default => nil
    change_column :holidays_non_billable_entries, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
    change_column :holidays_non_billable_entries, :created_at, :datetime
    change_column :holidays_non_billable_entries, :updated_at, :datetime
  end
end
