class ChangeHolidayDateToString < ActiveRecord::Migration
  def up
  	change_column :holidays, :date, :string
  end

  def down
  	change_column :holidays, :date, :date
  end
end
