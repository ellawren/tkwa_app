class AddDefunctAndMbeToReview < ActiveRecord::Migration
  def change
  	add_column :consultant_reviews, :defunct, :boolean
  	add_column :consultant_reviews, :mbe, :boolean
  end
end
