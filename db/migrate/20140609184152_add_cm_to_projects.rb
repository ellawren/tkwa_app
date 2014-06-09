class AddCmToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :cm, :string
  end
end
