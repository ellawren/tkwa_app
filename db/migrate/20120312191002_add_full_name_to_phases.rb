class AddFullNameToPhases < ActiveRecord::Migration
  def change
  	add_column :phases, :full_name, :string
  end
end
