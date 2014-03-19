# == Schema Information
#
# Table name: employee_teams
#
#  id         :integer         not null, primary key
#  project_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  role       :string(255)
#  pd_hours   :decimal(6, 2)
#  sd_hours   :decimal(6, 2)
#  dd_hours   :decimal(6, 2)
#  cd_hours   :decimal(6, 2)
#  bid_hours  :decimal(6, 2)
#  cca_hours  :decimal(6, 2)
#  int_hours  :decimal(6, 2)
#  his_hours  :decimal(6, 2)
#  add_hours  :decimal(6, 2)
#  user_id    :integer
#  rate       :decimal(5, 2)
#

class EmployeeTeam < ActiveRecord::Base
    include ApplicationHelper

	belongs_to :project
    belongs_to :user
    has_one :employee_role

	validates :project_id, :presence => true
    validates :user_id, :presence => true
    validates :role, :presence => true

    def employee_name
        User.find(self.user_id).name
    end

    def project_name
        Project.find(self.project_id).name
    end

    before_save do
        if self.rate.nil?
            self.rate = DataRecord.find_by_user_id_and_year(self.user_id, this_year).billable_rate || 110
        end
    end

    scope :ordered, {
        :select => "employee_teams.*",
        :joins => "INNER JOIN employee_roles ON employee_teams.role = employee_roles.name", 
        :order => "employee_roles.id"
    }

	scope :current, {
  		:select => "employee_teams.*",
  		:joins => "INNER JOIN projects ON employee_teams.project_id = projects.id", 
  		:conditions => ["status = ?", 'current' ],
        :order => "projects.name"
	}

	scope :completed, {
  		:select => "employee_teams.*",
  		:joins => "INNER JOIN projects ON employee_teams.project_id = projects.id", 
  		:conditions => ["status = ?", 'completed' ],
        :order => "projects.name"
	}


    # TRACKING
	
    # actual hours
    def employee_actual_hours(phase_number)
        TimeEntry.where(:project_id => self.project_id, :user_id => self.user_id, :phase_number => phase_number).sum(&:entry_total)
    end

    def employee_actual_hours_all
        TimeEntry.where(:project_id => self.project_id, :user_id => self.user_id).sum(&:entry_total)
    end

    # actual fees
    def employee_actual_fees(phase_number)
        employee_actual_hours(phase_number) * rate
    end

    def employee_actual_fees_all
        employee_actual_hours_all * rate
    end

    # target hours
    def employee_target_hours(phase_shorthand)
        eval("#{phase_shorthand}_hours").to_f
    end

    def employee_target_hours_all
        sum = 0
        Project.find(self.project_id).available_phases.map{|phase| sum += employee_target_hours(phase.shorthand)}
        sum
    end

    # target fees
    def employee_target_fees(phase_shorthand)
        employee_target_hours(phase_shorthand) * rate
    end

    def employee_target_fees_all
        employee_target_hours_all * rate
    end

    # percent used
    def percent_used
        (employee_actual_hours_all / self.employee_target_hours_all) * 100
    end

    # FORECAST

    def plan_entries
        PlanEntry.where(:project_id => self.project_id, :user_id => self.user_id)
    end

    def current_plan_entries
        PlanEntry.where(:project_id => self.project_id, :user_id => self.user_id, :week => this_week, :year => this_year)
    end

    def plan_entries_total
        PlanEntry.where(:project_id => self.project_id, :user_id => self.user_id).sum(&:entry_total)
    end

end
