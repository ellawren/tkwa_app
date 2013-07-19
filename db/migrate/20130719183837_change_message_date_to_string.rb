class ChangeMessageDateToString < ActiveRecord::Migration
  def up
  	change_column :messages, :expiration, :string
  end

  def down
  	change_column :messages, :expiration, :date
  end
end
