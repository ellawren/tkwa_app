# == Schema Information
#
# Table name: employee_teams
#
#  id         :integer         not null, primary key
#  contact_id :integer
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
#

class EmployeeTeam < ActiveRecord::Base
	attr_accessible :project_id, :contact_id, :role, :pd_hours, :sd_hours, :dd_hours, 
    :cd_hours, :bid_hours, :cca_hours, :int_hours, :his_hours, :add_hours
  default_scope :order => 'role DESC'

	belongs_to :project
	belongs_to :contact

	validates :project_id, :presence => true
  validates :contact_id, :presence => true

  def est_total
    pd = pd_hours || 0
    sd = sd_hours || 0
    dd = dd_hours || 0
    cd = cd_hours || 0
    bid = bid_hours || 0
    cca = cca_hours || 0
    int = int_hours || 0
    his = his_hours || 0
    add = add_hours || 0
    pd + sd + dd + cd + bid + cca + int + his + add
  end


	scope :current, {
  		:select => "employee_teams.*",
  		:joins => "INNER JOIN projects ON employee_teams.project_id = projects.id", 
  		:conditions => ["status = ?", 'Current' ]
	}

	scope :completed, {
  		:select => "employee_teams.*",
  		:joins => "INNER JOIN projects ON employee_teams.project_id = projects.id", 
  		:conditions => ["status = ?", 'Completed' ]
	}
	
   	EMPLOYEE_ROLES =   [	"Project Principal", "Project Manager", "Project Architect", 
   						"Project Designer", "Interior Designer", "Programming", "Historic Preservation",
   						"Graphic Designer"
    				 ]
end
