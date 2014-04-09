class RemoveFieldsFromExpenseReports < ActiveRecord::Migration
  def change
  	remove_column :expense_reports, :miles
  	remove_column :expense_reports, :food
  	remove_column :expense_reports, :parking
  	remove_column :expense_reports, :misc
  	remove_column :expense_reports, :description
  	remove_column :expense_reports, :date
  	remove_column :expense_reports, :project_id
  end

end
