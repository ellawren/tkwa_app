class RenameConsultantsConsultantRoles < ActiveRecord::Migration
  def up
  	rename_table :consultants_consultant_roles, :consultant_roles_consultants
  end

  def down
  	rename_table :consultant_roles_consultants, :consultants_consultant_roles
  end
end
