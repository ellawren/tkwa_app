class CreateLivingBuildingCategories < ActiveRecord::Migration
  def change
    create_table :living_building_categories do |t|
      t.string :version
      t.string :name

      t.timestamps
    end
  end
end
