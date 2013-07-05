class ChangeBirthdayToString < ActiveRecord::Migration
  def up
  	change_column :contacts, :birthday, :string
  end

  def down
  	change_column :contacts, :birthday, :date
  end
end
