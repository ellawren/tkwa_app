class RenameActualProjectColumn < ActiveRecord::Migration
  def change
  	rename_column :actuals, :project_id_id, :project_id
  end
end
