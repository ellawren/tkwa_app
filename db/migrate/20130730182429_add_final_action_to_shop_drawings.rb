class AddFinalActionToShopDrawings < ActiveRecord::Migration
  def change
  	add_column :shop_drawings, :final_action, :string
  end
end
