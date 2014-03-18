class RemoveDefaultFromRateAgain < ActiveRecord::Migration
  def change
  	change_column_default :employee_teams, :rate, nil
  end
end
