class DeleteHourlyBillingFromEmployees < ActiveRecord::Migration
  def up
  	remove_column :employees, :hourly_billing
  end

  def down
  	add_column  :employees, :hourly_billing, :decimal, :precision => 5, :scale => 2
  end
end
