class CreateLbStrategyGroups < ActiveRecord::Migration
  def change
    create_table :lb_strategy_groups do |t|
		t.integer :project_id
		t.string :required
      	t.timestamps
    end
  end
end