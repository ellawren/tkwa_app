class CreateProjectsServices < ActiveRecord::Migration
  def change
      create_table :projects_services, :id => false do |t|
      t.references :project, :null => false
      t.references :service, :null => false

      t.timestamps
    end
    add_index :projects_services, [:project_id, :service_id], :unique => true
  end
end
