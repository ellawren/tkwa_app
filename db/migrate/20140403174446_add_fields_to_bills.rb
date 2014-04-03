class AddFieldsToBills < ActiveRecord::Migration
  def change
  	add_column :bills, :invoice_number, :string
  	add_column :bills, :date_approved, :string
  end
end
