class RemoveStatusColumn < ActiveRecord::Migration
  def up
  	remove_column :timesheets, :status
  end

  def down
  	add_column  :timesheets, :status, :string
  end
end
