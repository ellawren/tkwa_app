class CreateMarketingCategoriesProjects < ActiveRecord::Migration
  def change
    create_table :marketing_categories_projects do |t|

    	t.integer :marketing_category_id, :null => false
    	t.integer :project_id, :null => false
      	t.timestamps

    end
  end
end
