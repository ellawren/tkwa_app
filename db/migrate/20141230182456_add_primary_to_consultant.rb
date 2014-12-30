class AddPrimaryToConsultant < ActiveRecord::Migration
  def change
  	add_column :consultants, :primary, :string
  end
end
