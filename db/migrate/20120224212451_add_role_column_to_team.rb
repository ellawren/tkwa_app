class AddRoleColumnToTeam < ActiveRecord::Migration
  def change
  	add_column :teams, :role, :string
  end
end
