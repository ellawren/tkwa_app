class CreateLivingBuildings < ActiveRecord::Migration
  def change
    create_table :living_buildings do |t|
		t.integer :version
      	t.timestamps
    end
  end
end
