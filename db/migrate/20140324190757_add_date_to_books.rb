class AddDateToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :date_checked_out, :datetime
  end
end
