class AddRateToEmployeeTeam < ActiveRecord::Migration
  def change
  	add_column :employee_teams, :rate, :decimal, :precision => 5, :scale => 2
  end
end
