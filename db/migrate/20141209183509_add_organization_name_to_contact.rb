class AddOrganizationNameToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :organization_name, :string
  	remove_column :consultants, :po_box
  	remove_column :consultants, :general_email
  end
end
