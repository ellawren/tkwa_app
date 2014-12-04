class AddConsultantFields < ActiveRecord::Migration
  def change
  	add_column :consultants, :po_box, :string
  	add_column :consultants, :general_email, :string
  end
end
