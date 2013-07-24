class ChangeProjectDatesToStrings < ActiveRecord::Migration
  def up
  	change_column :projects, :start_date, :string
  	change_column :projects, :completion_date, :string
  end

  def down
  	change_column :projects, :start_date, :date
  	change_column :projects, :completion_date, :date
  end
end
