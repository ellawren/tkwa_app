class ChangeMktDescriptionDataType < ActiveRecord::Migration
  def up
  	change_column :projects, :mkt_description, :text
  end

  def down
  	change_column :projects, :mkt_description, :string
  end
end
