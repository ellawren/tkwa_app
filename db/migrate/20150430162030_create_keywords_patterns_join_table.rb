class CreateKeywordsPatternsJoinTable < ActiveRecord::Migration

  def change
  	create_table :keywords_patterns, :id => false do |t|
	  t.references :keyword, :null => false
	  t.references :pattern, :null => false
	end

	# Adding the index can massively speed up join tables. Don't use the
	# unique if you allow duplicates.
	add_index(:keywords_patterns, [:keyword_id, :pattern_id], :unique => true)
  end

end
