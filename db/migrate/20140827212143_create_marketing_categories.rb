class CreateMarketingCategories < ActiveRecord::Migration
  def change
    create_table :marketing_categories do |t|
		t.string :name
      	t.timestamps
    end
  end
end
