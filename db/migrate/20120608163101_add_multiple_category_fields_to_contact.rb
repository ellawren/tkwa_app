class AddMultipleCategoryFieldsToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :cat01, :string
  	add_column :contacts, :cat02, :string
  	add_column :contacts, :cat03, :string
  	add_column :contacts, :cat04, :string
  	add_column :contacts, :cat05, :string
  	add_column :contacts, :cat06, :string
  end
end
