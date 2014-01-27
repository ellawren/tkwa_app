class DeleteExtraServices < ActiveRecord::Migration
  def up
  	remove_column :projects, :extra_services
  end

  def down
  	add_column :projects, :extra_services, :decimal,  :precision => 12, :scale => 2
  end
end
