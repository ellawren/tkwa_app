class ChangeBillingFieldDataTypesBack < ActiveRecord::Migration
  def up
  	change_column :projects, :contract_amount, :decimal, :precision => 12, :scale => 2
  	change_column :projects, :extra_services, :decimal, :precision => 12, :scale => 2
  end

  def down
  	change_column :projects, :contract_amount, :integer
  	change_column :projects, :extra_services, :integer
  end
end
