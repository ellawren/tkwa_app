class ChangeProjectViewDefaults < ActiveRecord::Migration
  def up
  	change_column :projects, :view_options, :string, default: ['scope', 'team', 'tracking', 'billing', 'schedule'], array: true
  end

  def down
  	change_column :projects, :view_options, :string, default: ['scope', 'team', 'tracking', 'billing', 'patterns', 'marketing'], array: true
  end
end
