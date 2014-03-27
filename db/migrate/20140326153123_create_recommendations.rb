class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
    	t.integer :book_id
      	t.integer :user_id

      	t.timestamps
    end
    add_index :recommendations, [:book_id, :user_id], :unique => true
  end
end
