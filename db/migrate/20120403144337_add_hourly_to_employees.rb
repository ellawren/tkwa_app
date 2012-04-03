class AddHourlyToEmployees < ActiveRecord::Migration
  def change
  	add_column :employees, :hourly, :decimal,   :precision => 4, :scale => 2
  end
end
