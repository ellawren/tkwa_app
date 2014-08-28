class ReCreateMarketingCategoriesProjects < ActiveRecord::Migration
  def change
      create_table :marketing_categories_projects, :id => false do |t|
      t.references :marketing_category, :null => false
      t.references :project, :null => false

      t.timestamps
    end
    add_index :marketing_categories_projects, [:marketing_category_id, :project_id], :unique => true, :name => "marketing_projects_index"
  end
end
