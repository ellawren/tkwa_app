class AddDefaultToRate < ActiveRecord::Migration
  def change
  	change_column :employee_teams, :rate, :decimal, :precision => 5, :scale => 2, :default => 90
  end
end
