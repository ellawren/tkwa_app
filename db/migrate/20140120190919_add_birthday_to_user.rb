class AddBirthdayToUser < ActiveRecord::Migration
  def change
  	add_column :users, :birth_month, :integer
  	add_column :users, :birth_day, :integer
  end
end
