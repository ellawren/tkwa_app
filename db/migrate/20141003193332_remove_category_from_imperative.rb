class RemoveCategoryFromImperative < ActiveRecord::Migration
  def change
  	remove_column :imperatives, :category
  end
end
