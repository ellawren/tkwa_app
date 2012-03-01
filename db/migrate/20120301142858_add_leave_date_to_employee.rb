class AddLeaveDateToEmployee < ActiveRecord::Migration
  def change
  	add_column :employees, :leave_date, :datetime
  end
end
