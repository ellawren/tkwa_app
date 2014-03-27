class AddRecommendationFields < ActiveRecord::Migration
  def change
  	add_column :recommendations, :date, :datetime
  	add_column :recommendations, :description, :text
  	add_attachment :recommendations, :photo
  end
end
