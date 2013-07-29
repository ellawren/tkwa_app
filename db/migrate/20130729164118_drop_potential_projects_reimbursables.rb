class DropPotentialProjectsReimbursables < ActiveRecord::Migration
  def up
  	drop_table :potential_projects_reimbursables
  end

  def down
  	create_table :potential_projects_reimbursables, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :reimbursable, :null => false

      t.timestamps
    end
  end
end
