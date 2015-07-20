class AddFirmToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :firm, :integer, :default => 1
  end
end
