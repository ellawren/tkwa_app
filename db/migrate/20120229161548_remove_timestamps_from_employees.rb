class RemoveTimestampsFromEmployees < ActiveRecord::Migration
  def up
  	change_column :employees, :created_at, :datetime, :null => true, :default => nil
    change_column :employees, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :employees, :created_at, :datetime
    change_column :employees, :updated_at, :datetime
  end
end
