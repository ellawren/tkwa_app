class AddActiveToUnassignedAndAvailableHours < ActiveRecord::Migration
  def change
  	add_column :unassigned_hours, :active, :boolean, :default => true
  	add_column :available_hours, :active, :boolean, :default => true
  	add_column :non_billable_hours, :active, :boolean, :default => true
  end
end
