class AddPostOfficeBoxToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :work_po_box, :string
  end
end
