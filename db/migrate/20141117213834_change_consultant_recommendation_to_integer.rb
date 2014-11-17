class ChangeConsultantRecommendationToInteger < ActiveRecord::Migration
  def change
  	change_column :consultant_reviews, :recommendation, 'integer USING CAST(recommendation AS integer)'
  end
end
