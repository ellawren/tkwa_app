class AddFieldsToEMployee < ActiveRecord::Migration
  def change
  	add_column :employees, :active, :boolean, :default => true
  end
end
