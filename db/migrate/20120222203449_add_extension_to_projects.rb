class AddExtensionToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :ext, :string
  end
end
