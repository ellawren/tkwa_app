class AddWorkAddressToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :work_address, :string
  	add_column :contacts, :work_phone, :string
  	add_column :contacts, :work_url, :string
  	add_column :contacts, :work_fax, :string
  end
end
