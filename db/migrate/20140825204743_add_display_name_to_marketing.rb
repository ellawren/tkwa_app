class AddDisplayNameToMarketing < ActiveRecord::Migration
  def change
  	add_column :projects, :mkt_display_name, :string
  end
end
