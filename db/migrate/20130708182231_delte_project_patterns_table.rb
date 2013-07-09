class DelteProjectPatternsTable < ActiveRecord::Migration
  	def up
  		drop_table :project_patterns
  	end

  	def down
  		create_table :project_patterns do |t|
	    	t.integer :project_id
	      	t.integer :pattern_id
	    	t.string :name
	    	t.text :issue
	    	t.text :solution
	    	t.string :author
	    	t.text :background
	    	t.string :group
	    	t.integer :rating
	    	t.text :challenges
	    	t.string :approval_status
	    	t.string :authors

	      	t.timestamps
    	end
  	end
end
