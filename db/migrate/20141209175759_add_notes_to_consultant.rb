class AddNotesToConsultant < ActiveRecord::Migration
  def change
  	add_column :consultants, :notes, :text
  end
end
