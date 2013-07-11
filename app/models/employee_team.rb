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
    pd = pd_hours.to_f
    sd = sd_hours.to_f
    dd = dd_hours.to_f
    cd = cd_hours.to_f
    bid = bid_hours.to_f
    cca = cca_hours.to_f
    int = int_hours.to_f
    his = his_hours.to_f
    add = add_hours.to_f
    pd + sd + dd + cd + bid + cca + int + his + add
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
   						"Graphic Designer"
    				 ]
end
