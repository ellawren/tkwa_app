class ChangeBillAmountField < ActiveRecord::Migration
  def up
  	change_column :bills, :amount, :decimal, :precision => 10, :scale => 2
  end
end
