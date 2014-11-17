class AddOrganizationIdToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :organization_id, :integer
  end
end
