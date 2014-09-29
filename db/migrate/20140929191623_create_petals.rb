class CreatePetals < ActiveRecord::Migration
  def change
    create_table :petals do |t|
    	t.integer :version
		t.string :category
		t.string :name
		t.integer :number
		t.text :short_desc
		t.text :full_desc
		t.text :strategies
      	t.timestamps
    end
  end
end
