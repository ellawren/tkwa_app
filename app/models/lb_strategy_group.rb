# == Schema Information
#
# Table name: lb_strategy_groups
#
#  id            :integer         not null, primary key
#  project_id    :integer
#  required      :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  imperative_id :integer
#

class LbStrategyGroup < ActiveRecord::Base
	belongs_to :project
	belongs_to :imperative
	has_many :lb_strategies
end


