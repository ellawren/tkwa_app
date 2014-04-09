class AddRecentBillingToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :recent_billing, :boolean, :default => false
  end
end
