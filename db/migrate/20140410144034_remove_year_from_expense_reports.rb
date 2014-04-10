class RemoveYearFromExpenseReports < ActiveRecord::Migration
  def change
  	remove_column :expense_reports, :year
  end
end
