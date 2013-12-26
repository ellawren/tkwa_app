class DeleteContactImportCategories < ActiveRecord::Migration
  def up
  	remove_column :contacts, :import_category
  end

  def down
  	add_column :contacts, :import_category, :text
  end
end
