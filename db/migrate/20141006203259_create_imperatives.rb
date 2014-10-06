class CreateImperatives < ActiveRecord::Migration
  def change
    create_table :imperatives do |t|
		t.string :name
		t.integer :number
		t.text :short_desc
		t.text :full_desc
		t.integer :petal_id
      	t.timestamps
    end
  end
end