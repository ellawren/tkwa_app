class AddConsultantToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :consultant_id, :integer
  end
end
