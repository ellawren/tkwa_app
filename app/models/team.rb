# == Schema Information
#
# Table name: teams
#
#  id         :integer         not null, primary key
#  project_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  role       :string(255)
#

class Team < ActiveRecord::Base
	attr_accessible :project_id, :user_id, :role

	belongs_to :project
	belongs_to :user

	validates :project_id, :presence => true
   	validates :user_id, :presence => true

   	STAFF_ROLES =   [	"Project Principal", "Project Manager", "Project Architect", 
   						"Project Designer", "Interior Designer", "Programming", "Historic Preservation",
   						"Graphic Designer"
    				 ]
end
