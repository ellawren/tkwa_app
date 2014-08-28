class MarketingCategoryNotNullThing < ActiveRecord::Migration
  def change
  	change_column :marketing_categories_projects, :created_at, :datetime, :null => true, :default => nil
  	change_column :marketing_categories_projects, :updated_at, :datetime, :null => true, :default => nil
  	remove_column :projects, :mkt_summary
  end
end
