class AddColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :address, :string
  	add_column :users, :cell_phone, :string
  	add_column :users, :home_phone, :string
  	add_column :users, :direct_phone, :string
  	add_column :users, :work_email, :string
  	add_column :users, :home_email, :string
  	add_column :users, :birthday, :date
  end
end
