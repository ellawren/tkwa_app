class AddTotalToTimeEntry < ActiveRecord::Migration
  def change
  	add_column :time_entries, :total, :decimal, :precision => 5, :scale => 2
  end
end
