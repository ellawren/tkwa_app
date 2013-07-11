class CreatePotentialProjectsServices < ActiveRecord::Migration
  def change
      create_table :potential_projects_services, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :service, :null => false

      t.timestamps
    end
    add_index :potential_projects_services, [:potential_project_id, :service_id], :unique => true, :name => "potential_services_index"
  end
end
