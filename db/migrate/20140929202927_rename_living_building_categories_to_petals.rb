class RenameLivingBuildingCategoriesToPetals < ActiveRecord::Migration
  def up
  	rename_table :living_building_categories, :petals
  end

  def down
  	rename_table :petals, :living_building_categories
  end
end
