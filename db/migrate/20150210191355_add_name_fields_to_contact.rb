class AddNameFieldsToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :first, :string
  	add_column :contacts, :last, :string
  end
end
