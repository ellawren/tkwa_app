class AddShortDescToPetals < ActiveRecord::Migration
  def change
  	add_column :petals, :short_desc, :text
  end
end
