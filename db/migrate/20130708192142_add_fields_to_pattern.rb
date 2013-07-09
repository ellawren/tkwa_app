class AddFieldsToPattern < ActiveRecord::Migration
  def change
  	add_column  :patterns, :number, :integer
  	add_column  :patterns, :group, :string
  	add_column  :patterns, :rating, :integer
  	add_column  :patterns, :authors, :string
  	add_column  :patterns, :challenges, :text
  	add_column  :patterns, :approval, :string
  end
end
