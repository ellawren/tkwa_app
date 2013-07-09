class AddProjectIdToPatterns < ActiveRecord::Migration
  def change
  	add_column  :patterns, :project_id, :integer
  end
end
