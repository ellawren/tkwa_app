class AddOrderToPatternGroups < ActiveRecord::Migration
  def change
  	add_column :pattern_groups, :order, :string
  end
end
