class RemoveLivingBuildingVersion < ActiveRecord::Migration
  def change
  	drop_table :living_buildings
  	remove_column :imperatives, :version
  	remove_column :petals, :version
  end

end
