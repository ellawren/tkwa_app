class AddCategoryToConsultant < ActiveRecord::Migration
  def change
  	add_column :consultants, :category, :integer
  end
end
