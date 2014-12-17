class AddRoleToConsultants < ActiveRecord::Migration
  def change
  	add_column :consultants, :contractor_category, :integer
  end
end
