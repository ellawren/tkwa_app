class AddStatusToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :status, :string
  	remove_column :books, :checked_out
  end
end
