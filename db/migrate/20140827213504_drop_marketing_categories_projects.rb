class DropMarketingCategoriesProjects < ActiveRecord::Migration
  def change
  	drop_table :marketing_categories_projects
  end
end
