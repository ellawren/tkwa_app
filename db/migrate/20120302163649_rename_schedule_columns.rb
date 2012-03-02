class RenameScheduleColumns < ActiveRecord::Migration
  def change
  	remove_column :projects, :construction_start
  	rename_column :projects, :design_start, :start_date
  	rename_column :projects, :completion, :completion_date
  end
end
