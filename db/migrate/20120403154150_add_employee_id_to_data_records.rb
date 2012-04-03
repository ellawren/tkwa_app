class AddEmployeeIdToDataRecords < ActiveRecord::Migration
  def change
  	add_column :data_records, :employee_id, :integer
  end
end
