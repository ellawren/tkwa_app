class ChangeCategoriesContactsTimestamps < ActiveRecord::Migration
  def up
    change_column :categories_contacts, :created_at, :datetime, :null => true, :default => nil
    change_column :categories_contacts, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
    change_column :categories_contacts, :created_at, :datetime
    change_column :categories_contacts, :updated_at, :datetime
  end
end
