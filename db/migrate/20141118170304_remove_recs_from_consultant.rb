class RemoveRecsFromConsultant < ActiveRecord::Migration
  def change
  	remove_column :consultants, :recommended
  	remove_column :consultants, :notes
  	drop_table :consultant_roles_consultants
  end

end
