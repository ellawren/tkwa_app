class AddBorrowerToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :borrower, :string
  end
end
