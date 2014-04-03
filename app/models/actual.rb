# == Schema Information
#
# Table name: actuals
#
#  id         :integer         not null, primary key
#  year       :integer
#  month      :integer
#  project_id :integer
#  amount     :decimal(8, 2)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#


class Actual < ActiveRecord::Base
	belongs_to :project

	scope :current, lambda {|id| where("project_id = ? AND year = ? AND month = ?", id, Date.today.cwyear, Date.today.month) }
end

