class AddAltContactToProjects < ActiveRecord::Migration
  def change
  	add_column  :projects, :alt_contact, :string
  end
end
