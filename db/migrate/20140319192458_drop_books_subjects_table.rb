class DropBooksSubjectsTable < ActiveRecord::Migration
  def up
  	drop_table :books_subjects
  end

  def down
      create_table :books_subjects, :id => false do |t|
      t.references :book, :null => false
      t.references :subject, :null => false

      t.timestamps
    end
    add_index :books_subjects, [:book_id, :subject_id], :unique => true
  end
end
