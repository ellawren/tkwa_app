class RemoveBookRecommendationIndex < ActiveRecord::Migration
  def change
  	remove_index(:recommendations, :name => 'index_recommendations_on_book_id_and_user_id')
  end
end
