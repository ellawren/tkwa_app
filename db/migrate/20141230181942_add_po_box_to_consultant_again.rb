class AddPoBoxToConsultantAgain < ActiveRecord::Migration
  def change
  	add_column :consultants, :po_box, :string
  end
end
