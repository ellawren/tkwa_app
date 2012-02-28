class CreateCategoriesContacts < ActiveRecord::Migration
  def change
      create_table :categories_contacts, :id => false do |t|
      t.references :category, :null => false
      t.references :contact, :null => false

      t.timestamps
    end
    add_index :categories_contacts, [:category_id, :contact_id], :unique => true
  end
end
