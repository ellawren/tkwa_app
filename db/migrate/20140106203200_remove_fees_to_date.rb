class RemoveFeesToDate < ActiveRecord::Migration
  def up
  	remove_column :projects, :fees_to_date
  end

  def down
  	add_column :projects, :fees_to_date, :decimal, :precision => 12, :scale => 2
  end
end
