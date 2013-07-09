class DeleteColumnsFromProjectPatterns < ActiveRecord::Migration
  def up
  	remove_column :project_patterns, :name
  	remove_column :project_patterns, :issue
  	remove_column :project_patterns, :solution
  	remove_column :project_patterns, :author
  	remove_column :project_patterns, :background
  	remove_column :project_patterns, :group
  	remove_column :project_patterns, :rating
  	remove_column :project_patterns, :challenges
  	remove_column :project_patterns, :approval_status
  	remove_column :project_patterns, :authors
  end

  def down
  	add_column :project_patterns, :name, :string
  	add_column :project_patterns, :issue, :text
  	add_column :project_patterns, :solution, :text
  	add_column :project_patterns, :author, :string
  	add_column :project_patterns, :background, :text
  	add_column :project_patterns, :group, :string
  	add_column :project_patterns, :rating, :integer
  	add_column :project_patterns, :challenges, :text
  	add_column :project_patterns, :approval_status, :string
  	add_column :project_patterns, :authors, :string
  end
end