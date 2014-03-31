class DropMonthlyBillings < ActiveRecord::Migration
  def change
  	drop_table :monthly_billings
  end
end
