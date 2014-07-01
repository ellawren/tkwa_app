class AddPatternGroupIdToPatterns < ActiveRecord::Migration
  def change
  	add_column :patterns, :pattern_group_id, :integer
  	remove_column :patterns, :group
  end
end
