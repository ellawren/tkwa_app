class ChangeBooksSubjectsTimestamps < ActiveRecord::Migration
  def up
  	change_column :books_subjects, :created_at, :datetime, :null => true, :default => nil
    change_column :books_subjects, :updated_at, :datetime, :null => true, :default => nil
  end

  def down
  	change_column :books_subjects, :created_at, :datetime
    change_column :books_subjects, :updated_at, :datetime
  end
end
