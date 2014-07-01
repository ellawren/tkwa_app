class AddNotesToPatterns < ActiveRecord::Migration
  def change
  	add_column :patterns, :notes, :text
  end
end
