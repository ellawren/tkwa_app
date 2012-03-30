class AddBillableGoalToEmployee < ActiveRecord::Migration
  def change
  	add_column :employees, :billable_goal, :decimal,   :precision => 4, :scale => 2
  end
end
