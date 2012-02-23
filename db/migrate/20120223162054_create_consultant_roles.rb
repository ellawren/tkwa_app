class CreateConsultantRoles < ActiveRecord::Migration
  def change
    create_table :consultant_roles do |t|
      t.string :consultant_role_name

      t.timestamps
    end
  end
end
