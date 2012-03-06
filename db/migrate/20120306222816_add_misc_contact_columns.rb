class AddMiscContactColumns < ActiveRecord::Migration
  def change
  	add_column :projects, :client_url, :string
  	add_column :contacts, :direct_ext, :string
  	add_column :contacts, :assistant, :string
  	add_column :contacts, :work_cell, :string
  end
end
