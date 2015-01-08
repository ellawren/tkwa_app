class AddTempVarToConsultants < ActiveRecord::Migration
  def change
  	add_column :consultants, :temp, :integer
  end
end
