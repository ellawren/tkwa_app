# == Schema Information
#
# Table name: plan_entries
#
#  id               :integer         not null, primary key
#  project_id       :integer         not null
#  hours            :integer(3)
#  year             :integer         not null
#  week             :integer         not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  user_id          :integer         not null
#  employee_team_id :integer
#

class PlanEntry < ActiveRecord::Base
	default_scope order('year, week')
  	belongs_to :employee_team

	scope :current, {
        :select => "plan_entries.*",
        :joins => "INNER JOIN projects ON projects.id = plan_entries.project_id", 
        :conditions => ["status = ?", "current" ]
    }
    
end
