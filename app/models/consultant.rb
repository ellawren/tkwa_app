# == Schema Information
#
# Table name: consultants
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Consultant < ActiveRecord::Base

	def projects
		ConsultantTeam.where(consultant_id: self.id).pluck(:project_id).uniq
	end

	def all_roles(project_id)
		array = ConsultantTeam.where(consultant_id: self.id, project_id: project_id).pluck(:consultant_role)
		array.to_s.gsub('"', '').gsub('[', '  ').gsub(']', '')
	end
	
end
