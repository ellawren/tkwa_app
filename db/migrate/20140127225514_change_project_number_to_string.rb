class ChangeProjectNumberToString < ActiveRecord::Migration
  def up
  	change_column :projects, :number, :string
  end

  def down
  	change_column :projects, :number, :decimal, :precision => 8,  :scale => 2
  end
end
