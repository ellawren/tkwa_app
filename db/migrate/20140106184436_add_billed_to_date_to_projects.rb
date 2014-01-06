class AddBilledToDateToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :billed_to_date, :decimal, :precision => 12, :scale => 2
  	add_column :projects, :fees_to_date, :decimal, :precision => 12, :scale => 2
  end
end
