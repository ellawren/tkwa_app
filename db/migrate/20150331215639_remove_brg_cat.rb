class RemoveBrgCat < ActiveRecord::Migration
  def up
  	remove_column :data_records, :brg_target
  end

  def down
  	add_column :data_records, :brg_target, :decimal, :precision => 6, :scale => 2
  end
end
