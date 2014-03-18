class RemoveDefaultFromRate < ActiveRecord::Migration
  def up
  	change_column :employee_teams, :rate, :decimal, :precision => 5, :scale => 2
  end

  def down
  	change_column :employee_teams, :rate, :decimal, :precision => 5, :scale => 2, :default => 90
  end
end
