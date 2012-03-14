class AddPhaseNumberToTimeEntries < ActiveRecord::Migration
  def change
  	add_column :time_entries, :phase_number, :integer
  end
end
