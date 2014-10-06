class RemoveAllLbTables < ActiveRecord::Migration
  def change
  	drop_table :imperatives
  	drop_table :lb_imperatives
  	drop_table :lb_petals
  	drop_table :living_building_categories
	drop_table :living_buildings
  end
end
