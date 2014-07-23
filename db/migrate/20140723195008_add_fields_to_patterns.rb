class AddFieldsToPatterns < ActiveRecord::Migration
  def change
  	add_column :patterns, :sources, :text
  	add_column :patterns, :photo_caption, :text
  	add_column :patterns, :diagram_caption, :text
  end
end
