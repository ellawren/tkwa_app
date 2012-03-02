class AddScheduleFieldsToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :design_start, :date
  	add_column :projects, :construction_start, :date
  	add_column :projects, :completion, :date
  	rename_column :projects, :ext, :billing_ext
  end
end
