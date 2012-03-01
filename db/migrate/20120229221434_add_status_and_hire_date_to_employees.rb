class AddStatusAndHireDateToEmployees < ActiveRecord::Migration
  def change
  	add_column :employees, :status, :string
  	add_column :employees, :hire_date, :datetime
  end
end
