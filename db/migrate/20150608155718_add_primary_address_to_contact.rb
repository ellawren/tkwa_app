class AddPrimaryAddressToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :primary_address, :string
  end
end
