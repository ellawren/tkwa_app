class AddIndexToProjectPatterns < ActiveRecord::Migration
  def change
    add_index :project_patterns, [:project_id, :pattern_id], :unique => true
  end
end
