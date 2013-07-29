class DropPotentialProjectsServices < ActiveRecord::Migration
  def up
  	drop_table :potential_projects_services
  end

  def down
  	create_table :potential_projects_services, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :service, :null => false

      t.timestamps
    end
  end
end
