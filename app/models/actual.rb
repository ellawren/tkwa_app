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
	scope :by_project, lambda {|id| where("project_id = ?", id) }

	def amount=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:amount] = num.to_f
    end

    def firm_id
        Project.find(self.project_id).firm_id
    end

    def self.total_for_month(year, month, firm)
    	Actual.joins(:project).where(month: month, year: year, :projects => { :firm_id => firm }).sum(:amount)
    end

end

