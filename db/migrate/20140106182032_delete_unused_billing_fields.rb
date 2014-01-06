class DeleteUnusedBillingFields < ActiveRecord::Migration
  def up
  	remove_column :projects, :billing_travel
  	remove_column :projects, :billing_consultant
  	remove_column :projects, :billing_outofpocket
  end

  def down
  	add_column :projects, :billing_travel, :string
  	add_column :projects, :billing_consultant, :string
  	add_column :projects, :billing_outofpocket, :string
  end
end
