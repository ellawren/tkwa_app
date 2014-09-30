class AddTextToPetals < ActiveRecord::Migration
  def change
  	add_column :petals, :intent, :text
  	add_column :petals, :conditions, :text
  end
end
