class AddDefaultToActuals < ActiveRecord::Migration
  def change
  	change_column :actuals, :amount, :decimal, :precision => 8, :scale => 2, :default => 0
  end
end
