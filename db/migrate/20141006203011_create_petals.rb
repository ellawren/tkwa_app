class CreatePetals < ActiveRecord::Migration
  def change
    create_table :petals do |t|
		t.string :name
		t.integer :numerical_order
		t.text :intent
		t.text :conditions
		t.string :subtitle
		t.text :short_desc
      	t.timestamps
    end
  end
end