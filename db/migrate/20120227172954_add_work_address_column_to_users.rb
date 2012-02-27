class AddWorkAddressColumnToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :employer, :string
  	add_column :users, :employer_address, :string
  	add_column :users, :employer_phone, :string
  	add_column :users, :employer_ext, :string
  	add_column :users, :employer_title, :string
  end
end
