class AddProjectNameToPattern < ActiveRecord::Migration
  def change
  	add_column :patterns, :project_name, :string
  end
end
