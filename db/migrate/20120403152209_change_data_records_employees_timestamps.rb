class ChangeDataRecordsEmployeesTimestamps < ActiveRecord::Migration
  def up
    change_column :data_records_employees, :created_at, :datetime, :null => true, :default => nil
    change_column :data_records_employees, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
    change_column :data_records_employees, :created_at, :datetime
    change_column :data_records_employees, :updated_at, :datetime
  end
end
