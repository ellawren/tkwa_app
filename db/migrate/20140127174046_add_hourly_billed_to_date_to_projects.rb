class AddHourlyBilledToDateToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :hourly_billed_to_date, :decimal,  :precision => 12, :scale => 2
  end
end
