class ChangeBillingFieldDataTypes < ActiveRecord::Migration
  def up
  	change_column :projects, :contract_amount, :integer
  	change_column :projects, :extra_services, :integer
  end

  def down
  	change_column :projects, :contract_amount, :decimal
  	change_column :projects, :extra_services, :decimal
  end
end
