class AddMonthToVacation < ActiveRecord::Migration
  def change
  	add_column :vacations, :month, :integer
  end
end
