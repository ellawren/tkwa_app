class AddBuildingAndBillingToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :building_type_id, :integer
  	add_column :projects, :billing_type_id, :integer
  end
end
