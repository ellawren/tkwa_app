class AddHourlyBillingToEmployees < ActiveRecord::Migration
  def change
  	add_column  :employees, :hourly_billing, :decimal, :precision => 5, :scale => 2
  end
end
