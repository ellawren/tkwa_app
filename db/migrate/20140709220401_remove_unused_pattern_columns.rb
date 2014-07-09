class RemoveUnusedPatternColumns < ActiveRecord::Migration
  def change
  	remove_column :patterns, :background
  	remove_column :patterns, :project_name
  	remove_column :patterns, :authors
  	remove_column :patterns, :approval
  end
end
