class ChangeOrderName < ActiveRecord::Migration
  def change
  	rename_column :living_building_categories, :order, :numerical_order
  end
end
