class AddBirthdayToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :birthday, :date
  end
end
