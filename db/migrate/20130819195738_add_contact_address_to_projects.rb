class AddContactAddressToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :contact_address, :string
  end
end
