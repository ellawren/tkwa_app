class RemoveEmployeeNumberFromUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :employee_number
  end

  def down
  	add_column :users, :employee_number, :integer
  end
end
