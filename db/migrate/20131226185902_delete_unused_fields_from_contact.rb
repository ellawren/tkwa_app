class DeleteUnusedFieldsFromContact < ActiveRecord::Migration
  def up
  	remove_column :contacts, :post_nominals
  	remove_column :contacts, :work_assistant
  	remove_column :contacts, :assistant
  	remove_column :contacts, :prefix
  	remove_column :contacts, :cat02
  	remove_column :contacts, :cat03
  	remove_column :contacts, :cat04
  	remove_column :contacts, :cat05
  	remove_column :contacts, :cat06
  	remove_column :contacts, :view_options
  end

  def down
  	add_column :contacts, :post_nominals, :string
  	add_column :contacts, :work_assistant, :string
  	add_column :contacts, :assistant, :string
  	add_column :contacts, :prefix, :string
  	add_column :contacts, :cat02, :string
  	add_column :contacts, :cat03, :string
  	add_column :contacts, :cat04, :string
  	add_column :contacts, :cat05, :string
  	add_column :contacts, :cat06, :string
  	add_column :contacts, :view_options, :string
  end
end
