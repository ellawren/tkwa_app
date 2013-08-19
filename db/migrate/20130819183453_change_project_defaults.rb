class ChangeProjectDefaults < ActiveRecord::Migration
  def up
  	change_column :projects, :view_options, :string, default: ['setup', 'scope', 'forecast', 'tracking', 'billing'], array: true
	change_column :projects, :status, :string, default: 'current'
  end

  def down
  	change_column :projects, :view_options, :string, default: ['scope', 'team', 'tracking', 'billing', 'schedule'], array: true
  	change_column :projects, :status, :string
  end
end
