class ChangeMileageDecimalPlaces < ActiveRecord::Migration
  def change
  	change_column :globals, :mileage, :decimal, :precision => 5, :scale => 3
  end
end
