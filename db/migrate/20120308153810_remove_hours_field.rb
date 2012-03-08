class RemoveHoursField < ActiveRecord::Migration
  def change
	  remove_column :time_entries, :hours
  end
end
