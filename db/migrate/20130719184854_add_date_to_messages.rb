class AddDateToMessages < ActiveRecord::Migration
  def change
  	add_column  :messages, :exp_date, :date
  end
end
