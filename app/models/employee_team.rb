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

    def plan_entries
        PlanEntry.find_all_by_project_id_and_user_id(self.project_id, self.user_id)
    end

    def current_plan_entries
        array = []
        plan_entries = PlanEntry.find_all_by_project_id_and_user_id_and_week_and_year(self.project_id, self.user_id, this_week, this_year)
        plan_entries.each do |p|
            if p.hours
                array.push(p)
            end
        end
        array
    end

    def plan_entries_total
        array = []
        sum = 0
        plan_entries = PlanEntry.find_all_by_project_id_and_user_id(self.project_id, self.user_id)

        plan_entries.each do |p|
            if p.hours
                array.push(p.hours)
            end
        end
        array.map{|x| sum += x}
        sum
    end
	
    # sum of actual hours entered for project, by employee
    def employee_actual(phase)
        if phase == "Total"
            time_entries = TimeEntry.find_all_by_project_id_and_user_id(self.project_id, self.user_id)
            array = []
            sum = 0
            time_entries.each do |t| 
                if Project.find(self.project_id).available_phases.map{|a| a.number}.include? t.phase_number
                    array.push(t.entry_total)
                end
            end
            array.map{|x| sum += x}
            sum
        else
            time_entries = TimeEntry.find_all_by_project_id_and_user_id_and_phase_number(self.project_id, self.user_id, phase)
            array = []
            sum = 0
            time_entries.each do |t| 
                array.push(t.entry_total)
            end
            array.map{|x| sum += x}
            sum
        end
    end

    # sum of target hours entered for project
    def est_total
        array = []
        sum = 0
        Project.find(self.project_id).available_phases.each do |phase|
            array.push( eval("#{phase.shorthand}_hours.to_f") )
        end
        array.map{|x| sum += x}
        sum.to_f
    end

    def percent_used
        percent = (self.employee_actual('Total') / self.est_total) * 100
    end

end
