class AddPetalIdToImperative < ActiveRecord::Migration
  def change
  	add_column :imperatives, :petal_id, :integer
  end
end
