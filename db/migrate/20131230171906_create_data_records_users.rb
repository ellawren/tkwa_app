class CreateDataRecordsUsers < ActiveRecord::Migration
  def change
      create_table :data_records_users, :id => false do |t|
      t.references :data_record, :null => false
      t.references :user, :null => false

      t.timestamps
    end
    add_index :data_records_users, [:data_record_id, :user_id], :unique => true
  end
end