class AddBillingFieldsToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :contract_amount, :decimal, :precision => 12, :scale => 2
  	add_column :projects, :extra_services, :decimal, :precision => 12, :scale => 2
  end
end