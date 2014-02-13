class RemoveUnusedEmployeeFields < ActiveRecord::Migration
  def up
  	remove_column :employees, :active
  	remove_column :employees, :status
  	remove_column :employees, :title
  end

  def down
  	add_column :employees, :active, :boolean, :default => true
  	add_column :employees, :status, :string
  	add_column :employees, :title, :string
  end
end
