class AddLocationToConsultants < ActiveRecord::Migration
  def change
  	add_column :consultants, :location, :string
  	add_column :consultants, :department, :string
  end
end
