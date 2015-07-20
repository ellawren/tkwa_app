class RenameProjectsFirm < ActiveRecord::Migration
  def change
  	rename_column :projects, :firm, :firm_id
  end

end
