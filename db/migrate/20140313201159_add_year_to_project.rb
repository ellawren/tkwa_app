class AddYearToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :year, :integer
  end
end
