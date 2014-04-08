class AddActiveToPlanEntry < ActiveRecord::Migration
  def change
  	add_column :plan_entries, :active, :boolean, :default => true
  end
end
