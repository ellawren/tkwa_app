class DropDataRecordsEmployees < ActiveRecord::Migration
  def up
  	drop_table :data_records_employees
  end

  def down
	    create_table :data_records_employees, :id => false do |t|
	      t.references :data_record, :null => false
	      t.references :employee, :null => false

	      t.timestamps
	    end
	    add_index :data_records_employees, [:data_record_id, :employee_id], :unique => true
  end
end
