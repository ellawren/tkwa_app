class RenameListMemberName < ActiveRecord::Migration
  def up
  	rename_column :list_members, :name, :contact_name
  end

  def down
  	rename_column :list_members, :contact_name, :name
  end
end
