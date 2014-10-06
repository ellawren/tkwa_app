class RemoveAllLbTables < ActiveRecord::Migration
  def change
  	drop_table :imperatives
  	drop_table :petals
	drop_table :living_buildings
  end
end
