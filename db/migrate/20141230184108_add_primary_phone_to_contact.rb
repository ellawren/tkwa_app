class AddPrimaryPhoneToContact < ActiveRecord::Migration
  def change
  	add_column :consultants, :primary_phone, :string
  end
end
