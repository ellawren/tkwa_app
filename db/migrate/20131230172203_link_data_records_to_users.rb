class LinkDataRecordsToUsers < ActiveRecord::Migration
  def up
  	add_column :data_records, :user_id, :integer, :null => false
  	remove_column :data_records, :employee_id
  end

  def down
  	add_column :data_records, :employee_id, :integer, :null => false
  	remove_column :data_records, :user_id
  end
end
