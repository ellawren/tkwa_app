class AddFamilyToUser < ActiveRecord::Migration
  def change
  	add_column :users, :family, :text
  end
end
