class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :category
      t.integer :index
      t.string :shelf_location
      t.string :type
      t.text :loc_data
      t.text :subjects

      t.timestamps
    end
  end
end
