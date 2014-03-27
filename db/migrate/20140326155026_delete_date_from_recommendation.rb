class DeleteDateFromRecommendation < ActiveRecord::Migration
  def change
  	remove_column :recommendations, :date
  end
end
