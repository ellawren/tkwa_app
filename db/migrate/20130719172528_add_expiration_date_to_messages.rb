class AddExpirationDateToMessages < ActiveRecord::Migration
  def change
  	add_column  :messages, :expiration, :date
  end
end
