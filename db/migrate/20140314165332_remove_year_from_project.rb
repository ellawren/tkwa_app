class RemoveYearFromProject < ActiveRecord::Migration
  def up
  	remove_column :projects, :year
  end

  def down
  	add_column :projects, :year, :integer
  end
end
