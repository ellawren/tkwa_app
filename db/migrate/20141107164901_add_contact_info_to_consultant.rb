class AddContactInfoToConsultant < ActiveRecord::Migration
  def change
  	add_column :consultants, :address, :string
  	add_column :consultants, :phone, :string
  	add_column :consultants, :fax, :string
  	add_column :consultants, :url, :string
  	add_column :consultants, :notes, :text
  	add_column :consultants, :recommended, :boolean
  end
end
