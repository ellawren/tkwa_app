class ChangeRecommendedToString < ActiveRecord::Migration
  def up
  	change_column :consultants, :recommended, :string, :default => "n/a"
  end

  def down
  	change_column :consultants, :recommended, :boolean
  end
end
