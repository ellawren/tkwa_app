class AddYearToTimeEntry < ActiveRecord::Migration
  def change
  	add_column :time_entries, :year, :integer
  end
end
