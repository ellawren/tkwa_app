class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
	  t.integer :user_id
      t.integer :contact_id

      t.timestamps
    end
    add_index :employees, :user_id
    add_index :employees, :contact_id
    add_index :employees, [:user_id, :contact_id], :unique => true
  end
end
