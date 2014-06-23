class RemoveBuildingTypeandBillingFromProjects < ActiveRecord::Migration
  def change
  	remove_column :projects, :building_type
  	remove_column :projects, :billing_type
  end
end
