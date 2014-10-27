class AddImperativeIdToLbStrategyGroup < ActiveRecord::Migration
  def change
  	add_column :lb_strategy_groups, :imperative_id, :integer
  end
end
