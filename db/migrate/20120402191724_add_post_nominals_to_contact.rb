class AddPostNominalsToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :post_nominals, :string
  	add_column :contacts, :prefix, :string
  end
end
