class AddDefaultToStatus < ActiveRecord::Migration
  def change
  	change_column :books, :status, :string, :default => "available"
  end
end
