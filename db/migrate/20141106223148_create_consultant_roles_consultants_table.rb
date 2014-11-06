class CreateConsultantRolesConsultantsTable < ActiveRecord::Migration
  def change
    create_table :consultants_consultant_roles do |t|
		t.integer :consultant_id, :null => false
		t.integer :consultant_role_id, :null => false
      	t.timestamps
    end
  end
end
