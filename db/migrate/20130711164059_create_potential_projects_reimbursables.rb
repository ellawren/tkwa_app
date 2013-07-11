class CreatePotentialProjectsReimbursables < ActiveRecord::Migration
  def change
      create_table :potential_projects_reimbursables, :id => false do |t|
      t.references :potential_project, :null => false
      t.references :reimbursable, :null => false

      t.timestamps
    end
    add_index :potential_projects_reimbursables, [:potential_project_id, :reimbursable_id], :unique => true, :name => "potential_reimbursables_index"
  end
end
