class AddUserToPlanEntry < ActiveRecord::Migration
  def change
  	add_column :plan_entries, :user_id, :integer
  	remove_column :plan_entries, :employee_id
  end
end
