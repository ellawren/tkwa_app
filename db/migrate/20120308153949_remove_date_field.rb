class RemoveDateField < ActiveRecord::Migration
  def change
	  remove_column :time_entries, :date
  end
end
