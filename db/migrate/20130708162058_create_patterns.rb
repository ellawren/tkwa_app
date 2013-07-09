class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
    	t.string :name
    	t.text :issue
    	t.text :solution
    	t.string :author
    	t.text :background

      	t.timestamps
    end
  end
end
