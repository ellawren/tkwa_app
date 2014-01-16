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
#

class EmployeeTeam < ActiveRecord::Base
	attr_accessible :project_id, :user_id, :role, :pd_hours, :sd_hours, :dd_hours, 
    :cd_hours, :bid_hours, :cca_hours, :int_hours, :his_hours, :add_hours
  default_scope :order => 'role DESC'

	belongs_to :project
  belongs_to :user

	validates :project_id, :presence => true
  validates :user_id, :presence => true

  def employee_name
    User.find(self.user_id).name
  end

  def project_name
    Project.find(self.project_id).name
  end

	scope :current, {
  		:select => "employee_teams.*",
  		:joins => "INNER JOIN projects ON employee_teams.project_id = projects.id", 
  		:conditions => ["status = ?", 'current' ]
	}

	scope :completed, {
  		:select => "employee_teams.*",
  		:joins => "INNER JOIN projects ON employee_teams.project_id = projects.id", 
  		:conditions => ["status = ?", 'completed' ]
	}
	
   	EMPLOYEE_ROLES =   [	"Project Principal", "Project Manager", "Project Architect", 
   						"Project Designer", "Interior Designer", "Programming", "Historic Preservation",
   						"Graphic Designer", "Project Intern", "Administration"
    				 ]


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

end
