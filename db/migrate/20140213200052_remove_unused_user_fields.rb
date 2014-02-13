class RemoveUnusedUserFields < ActiveRecord::Migration
  def up
  	remove_column :users, :employee_number
  	remove_column :users, :contact_id
  	remove_column :users, :status
  	remove_column :users, :hire_date
  	remove_column :users, :leave_date
  	remove_column :users, :birth_month
  	remove_column :users, :birth_day
  	remove_column :users, :title
  	remove_column :users, :family
  end

  def down
  	add_column :users, :employee_number, :integer
  	add_column :users, :contact_id, :integer
  	add_column :users, :status, :string
  	add_column :users, :hire_date, :string
  	add_column :users, :leave_date, :string
  	add_column :users, :birth_month, :integer
  	add_column :users, :birth_day, :integer
  	add_column :users, :title, :string
  	add_column :users, :family, :text
  end
end
