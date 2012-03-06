class AddHoursFieldsToEmployeeTeams < ActiveRecord::Migration
  def change
  	add_column :employee_teams, :pd_hours, :decimal, :precision => 6, :scale => 2
  	add_column :employee_teams, :sd_hours, :decimal, :precision => 6, :scale => 2
  	add_column :employee_teams, :dd_hours, :decimal, :precision => 6, :scale => 2
  	add_column :employee_teams, :cd_hours, :decimal, :precision => 6, :scale => 2
  	add_column :employee_teams, :bid_hours, :decimal, :precision => 6, :scale => 2
  	add_column :employee_teams, :cca_hours, :decimal, :precision => 6, :scale => 2
  	add_column :employee_teams, :int_hours, :decimal, :precision => 6, :scale => 2
  	add_column :employee_teams, :his_hours, :decimal, :precision => 6, :scale => 2
  	add_column :employee_teams, :add_hours, :decimal, :precision => 6, :scale => 2
  end
end
