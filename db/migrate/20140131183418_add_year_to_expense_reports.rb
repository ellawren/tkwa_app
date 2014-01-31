class AddYearToExpenseReports < ActiveRecord::Migration
  def change
  	add_column :expense_reports, :year, :integer
  end
end
