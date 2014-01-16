class MakeUserIdNotNull < ActiveRecord::Migration
  def up
  	change_column :plan_entries, :user_id, :integer, :null => false
  end

  def down
  	change_column :plan_entries, :user_id, :integer
  end
end
