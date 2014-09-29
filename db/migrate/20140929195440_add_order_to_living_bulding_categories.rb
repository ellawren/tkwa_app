class AddOrderToLivingBuldingCategories < ActiveRecord::Migration
  def change
  	add_column :living_building_categories, :order, :integer
  end
end
