class AddDatePrintedToExpenseReport < ActiveRecord::Migration
  def change
  	add_column :expense_reports, :date_printed, :date
  end
end
