class ChangeSubjectNumberToString < ActiveRecord::Migration
  def up
  	change_column :subjects, :number, :string
  end

  def down
  	change_column :subjects, :number, :integer
  end
end
