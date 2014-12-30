class ChangePrimaryPhoneToContact < ActiveRecord::Migration
  def change
  	remove_column :consultants, :primary_phone
  	add_column :contacts, :primary_phone, :string
  end
end
