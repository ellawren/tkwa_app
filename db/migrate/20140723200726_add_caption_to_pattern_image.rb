class AddCaptionToPatternImage < ActiveRecord::Migration
  def change
  	add_column :pattern_images, :caption, :text
  end
end
