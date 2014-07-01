class AddProjectsIndex < ActiveRecord::Migration
  def change
  	add_index(:projects, :name)
  end
end
