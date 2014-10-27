# == Schema Information
#
# Table name: lb_strategies
#
#  id                   :integer         not null, primary key
#  lb_strategy_group_id :integer
#  solution             :text
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

class LbStrategy < ActiveRecord::Base
  belongs_to :lb_strategy_group
end


