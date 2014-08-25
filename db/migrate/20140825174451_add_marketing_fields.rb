class AddMarketingFields < ActiveRecord::Migration
  def change
  	add_column :projects, :mkt_last_edited_by, :string
  	add_column :projects, :mkt_summary, :string
  	add_column :projects, :mkt_active, :boolean, :default => false
  end
end
