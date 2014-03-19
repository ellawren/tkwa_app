class AddSubjectToBook < ActiveRecord::Migration
  def change
  	add_column :books, :subject_id, :integer
  end
end
