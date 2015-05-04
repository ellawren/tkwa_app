class CreateKeyCategories < ActiveRecord::Migration
  def change
    create_table :key_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
