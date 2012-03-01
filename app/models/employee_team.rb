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
#

class EmployeeTeam < ActiveRecord::Base
	attr_accessible :project_id, :contact_id, :role

	belongs_to :project
	belongs_to :contact

	validates :project_id, :presence => true
   	validates :contact_id, :presence => true

   	EMPLOYEE_ROLES =   [	"Project Principal", "Project Manager", "Project Architect", 
   						"Project Designer", "Interior Designer", "Programming", "Historic Preservation",
   						"Graphic Designer"
    				 ]
end
