# == Schema Information
#
# Table name: consultant_teams
#
#  id              :integer         not null, primary key
#  project_id      :integer
#  consultant_id   :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  consultant_role :string(255)
#

class ConsultantTeam < ActiveRecord::Base
	attr_accessible :project_id, :consultant_id, :consultant_role

	belongs_to :project
	belongs_to :consultant

	validates :project_id, :presence => true
   	validates :consultant_id, :presence => true

   	CONSULTANT_ROLES =   [	"HVAC", "MEP Engineering", "Landscape Design", "Fire Protection",
   						"Structural Engineering", "Civil Engineering", "Acoustics", "A/V",
   						"Plumbing"
    				 ]

end
