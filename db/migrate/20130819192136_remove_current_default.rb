class RemoveCurrentDefault < ActiveRecord::Migration
  def up
  	change_column :projects, :status, :string
  end

  def down
  	change_column :projects, :status, :string, default: 'current'
  end
end
