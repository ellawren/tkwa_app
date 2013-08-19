class ChangePlanEntryHoursDataType < ActiveRecord::Migration
  def up
  	change_column :plan_entries, :hours, :decimal, :precision => 3, :scale => 0
  end

  def down
  	change_column :plan_entries, :hours, :decimal, :precision => 6, :scale => 2
  end
end
