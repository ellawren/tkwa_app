class RenameContactsCat01 < ActiveRecord::Migration
  def up
  	rename_column :contacts, :cat01, :cat_number
  end

  def down
  	rename_column :contacts, :cat_number, :cat01
  end
end
