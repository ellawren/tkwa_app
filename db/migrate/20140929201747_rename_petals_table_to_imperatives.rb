class RenamePetalsTableToImperatives < ActiveRecord::Migration
  def up
  	rename_table :petals, :imperatives
  end

  def down
  	rename_table :imperatives, :petals
  end
end
