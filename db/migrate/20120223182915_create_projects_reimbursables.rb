class CreateProjectsReimbursables < ActiveRecord::Migration
  def change
      create_table :projects_reimbursables, :id => false do |t|
      t.references :project, :null => false
      t.references :reimbursable, :null => false

      t.timestamps
    end
    add_index :projects_reimbursables, [:project_id, :reimbursable_id], :unique => true
  end
end
