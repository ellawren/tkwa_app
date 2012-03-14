class DeletePhaseColumn < ActiveRecord::Migration
  def up
  	remove_column :time_entries, :phase
  end

  def down
  	add_column :time_entries, :phase, :string
  end
end
