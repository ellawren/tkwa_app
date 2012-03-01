class AddEmployeeNumberToEmployees < ActiveRecord::Migration
  def change
  	add_column :employees, :number, :integer
  end
end
