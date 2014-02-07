class AddNameToListMembers < ActiveRecord::Migration
  def change
  	add_column :list_members, :name, :string
  end
end
