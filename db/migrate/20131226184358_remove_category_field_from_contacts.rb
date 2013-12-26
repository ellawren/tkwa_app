class RemoveCategoryFieldFromContacts < ActiveRecord::Migration
  def up
  	remove_column :contacts, :category
  end

  def down
  	add_column :contacts, :category, :string
  end
end
