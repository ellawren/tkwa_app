class AddYearToVacations < ActiveRecord::Migration
  def change
  	add_column :vacations, :year, :integer
  end
end
