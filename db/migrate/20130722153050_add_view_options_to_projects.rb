class AddViewOptionsToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :view_options, :string, default: ['scope', 'team', 'tracking', 'billing', 'patterns', 'marketing'], array: true
  end
end
