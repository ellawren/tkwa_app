class RenameMultiplierColumn < ActiveRecord::Migration
  def up
  	rename_column :globals, :multipler, :multiplier
  end

  def down
  	rename_column :globals, :multiplier, :multipler 
  end
end
