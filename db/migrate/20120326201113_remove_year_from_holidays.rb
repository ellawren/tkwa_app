class RemoveYearFromHolidays < ActiveRecord::Migration
  def up
  	remove_column :holidays, :year
  end

  def down
  	add_column :holidays, :year, :integer
  end
end
