class DeleteMicropostsAndRelationships < ActiveRecord::Migration
  def change
  	drop_table :microposts
  	drop_table :relationships
  end

end
