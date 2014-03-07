class ChangeTaskAndNbCategoryToInteger < ActiveRecord::Migration
  def up
  	change_column :time_entries, :task, 'integer USING CAST(task AS integer)'
  	change_column :non_billable_entries, :category, 'integer USING CAST(category AS integer)'
  end

  def down
  	change_column :time_entries, :task, :string
  	change_column :non_billable_entries, :category, :string
  end
end
