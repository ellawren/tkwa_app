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
#  active           :boolean         default(TRUE)
#

class PlanEntry < ActiveRecord::Base
	default_scope order('year, week')
  	belongs_to :employee_team

    scope :active, where(:active => true)

	scope :current, {
        :select => "plan_entries.*",
        :joins => "INNER JOIN projects ON projects.id = plan_entries.project_id", 
        :conditions => ["status = ?", "current" ]
    }

    after_initialize do
    	if self.employee_team_id.nil?
    		e = EmployeeTeam.where(project_id: self.project_id, user_id: self.user_id).first
    		self.employee_team_id = e.id
    	else
    		self.project_id ||= EmployeeTeam.find(self.employee_team_id).project_id
			self.user_id ||= EmployeeTeam.find(self.employee_team_id).user_id
    	end

        test = Date.commercial(self.year, self.week, 1) - 1 
        curr = Date.commercial(Date.today.year, Date.today.cweek, 1) - 1
        end_range = curr + 15.weeks
        begin_range = curr - 2.weeks
        if test <= end_range && test >= begin_range
            self.active = true
        else
            self.active = false
        end
    end
    
end
