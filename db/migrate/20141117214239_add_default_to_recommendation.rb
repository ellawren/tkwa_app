class AddDefaultToRecommendation < ActiveRecord::Migration
  def change
  	change_column :consultant_reviews, :recommendation, :integer, :default => 3
  end
end
