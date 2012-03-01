class DeleteColumnsFromUsersTable < ActiveRecord::Migration
  def up
  	remove_column :users, :address
  	remove_column :users, :cell_phone
  	remove_column :users, :home_phone
  	remove_column :users, :direct_phone
  	remove_column :users, :work_email
  	remove_column :users, :home_email
  	remove_column :users, :birthday
	remove_column :users, :employer
  	remove_column :users, :employer_address
  	remove_column :users, :employer_phone
  	remove_column :users, :employer_ext
  	remove_column :users, :employer_title
  end

  def down
  	add_column :users, :address, :string
  	add_column :users, :cell_phone, :string
  	add_column :users, :home_phone, :string
  	add_column :users, :direct_phone, :string
  	add_column :users, :work_email, :string
  	add_column :users, :home_email, :string
  	add_column :users, :birthday, :date
  	add_column :users, :employer, :string
  	add_column :users, :employer_address, :string
  	add_column :users, :employer_phone, :string
  	add_column :users, :employer_ext, :string
  	add_column :users, :employer_title, :string
  end
end
