class CreateEmployeeJoinModel < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :contact_id
      t.integer :user_id

      	t.integer  :employee_number
    	t.integer  :contact_id
    	t.string   :status
	    t.string   :hire_date
	    t.string   :leave_date
	    t.integer  :birth_month
	    t.integer  :birth_day
	    t.string   :title
	    t.text     :family

      t.timestamps
    end
    add_index :employees, :contact_id
    add_index :employees, :user_id
    add_index :employees, [:contact_id, :user_id], :unique => true
  end
end