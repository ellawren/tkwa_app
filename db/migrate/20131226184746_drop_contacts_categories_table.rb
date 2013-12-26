class DropContactsCategoriesTable < ActiveRecord::Migration
  def up
  	drop_table :categories_contacts
  end

  def down
      	create_table :categories_contacts, :id => false do |t|
	      t.references :category, :null => false
	      t.references :contact, :null => false

	      t.timestamps
    	end
  end
end
