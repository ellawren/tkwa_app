class AddPrintedToExpenseReport < ActiveRecord::Migration
  def change
  	add_column :expense_reports, :printed, :boolean, :default => false
  end
end
