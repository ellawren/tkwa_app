class AddYearAndWeekAndDayToHoliday < ActiveRecord::Migration
  def change
  	add_column :holidays, :date_object, :date
  	add_column :holidays, :year, :integer
  	add_column :holidays, :week, :integer
  	add_column :holidays, :day, :integer
  end
end
