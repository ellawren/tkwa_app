class AddCategoryToOrganization < ActiveRecord::Migration
  def change
  	add_column :organizations, :category, :integer
  end
end
