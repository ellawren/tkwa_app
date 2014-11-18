class AddRoleToReviews < ActiveRecord::Migration
  def change
  	add_column :consultant_reviews, :role, :string
  end
end
