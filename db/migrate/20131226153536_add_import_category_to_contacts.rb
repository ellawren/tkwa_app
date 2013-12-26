class AddImportCategoryToContacts < ActiveRecord::Migration
  def change
  	add_column :contacts, :import_category, :text
  end
end
