class CreateLbStrategies < ActiveRecord::Migration
  def change
    create_table :lb_strategies do |t|
		t.integer :lb_strategy_group_id
		t.text :solution
      	t.timestamps
    end
  end
end