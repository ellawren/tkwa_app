class AddContactExtToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :contact_ext, :string
  end
end
