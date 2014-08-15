class AddTotalToNonBillableEntries < ActiveRecord::Migration
  def change
  	add_column :non_billable_entries, :total, :decimal, :precision => 5, :scale => 2
  end
end
