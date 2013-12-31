class AddEmployeeInfoToUser < ActiveRecord::Migration
  def change
  	add_column :users, :employee_number, :integer
  	add_column :users, :contact_id, :integer
  	add_column :users, :status, :string
  	add_column :users, :hire_date, :string
  	add_column :users, :leave_date, :string
  end
end
