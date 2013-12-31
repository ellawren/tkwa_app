class AddDescriptionToPhases < ActiveRecord::Migration
  def change
  	add_column :phases, :description, :text
  end
end
