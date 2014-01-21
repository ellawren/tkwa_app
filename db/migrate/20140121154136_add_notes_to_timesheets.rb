class AddNotesToTimesheets < ActiveRecord::Migration
  def change
  	add_column :timesheets, :notes, :text
  end
end
