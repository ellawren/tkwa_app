class ChangeTimesheetsCompleteDefault < ActiveRecord::Migration
  def change
  	change_column_default(:timesheets,:complete,true)
  end
end
