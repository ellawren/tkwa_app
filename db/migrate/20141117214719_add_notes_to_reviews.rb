class AddNotesToReviews < ActiveRecord::Migration
  def change
  	add_column :consultant_reviews, :notes, :string
  end
end
