class RemoveAllLbTables < ActiveRecord::Migration
  def change
  	drop_table :imperatives
  	drop_table :petals
  end
end
