class ChangeNumberType < ActiveRecord::Migration
  def up
  	change_column :projects, :number, :decimal, { :precision => 8, :scale => 2 }
  end

  def down
  	change_column :projects, :number, :decimal
  end
end
