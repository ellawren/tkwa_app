class AddSelectedYearToTimesheets < ActiveRecord::Migration
  def change
  	add_column :timesheets, :selected_year, :integer
  end
end
