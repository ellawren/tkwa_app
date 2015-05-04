class AddKeyCategoryToKeyword < ActiveRecord::Migration
  def change
  	add_column :keywords, :key_category_id, :integer
  end
end
