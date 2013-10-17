class RemoveWorkInfoFromContact < ActiveRecord::Migration
  def up
  	remove_column :contacts, :work_company
  	remove_column :contacts, :work_address
  	remove_column :contacts, :work_phone
  	remove_column :contacts, :work_fax
  	remove_column :contacts, :work_url
  end

  def down
  	add_column :contacts, :work_company, :string
  	add_column :contacts, :work_address, :string
  	add_column :contacts, :work_phone, :string
  	add_column :contacts, :work_fax, :string
  	add_column :contacts, :work_url, :string
  end
end
