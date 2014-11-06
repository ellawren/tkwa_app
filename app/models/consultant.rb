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

	has_many :consultant_teams
	has_many :projects, :through => :consultant_teams,  :select => 'distinct projects.*'
	has_and_belongs_to_many :consultant_roles

	# next/prev
    scope :next, lambda {|id| where("id > ?", id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?", id).order("id DESC") }

    def next
        Consultant.next(self.id).first
    end

    def previous
        Consultant.previous(self.id).first
    end
    #------------------------------------
	
	def all_projects #need to use this instead of calling via the association to get alpha sort
		array = ConsultantTeam.where(consultant_id: self.id).pluck(:project_id).uniq
		Project.alpha.find(array)
	end

	def roles 
		array = ConsultantTeam.where(consultant_id: self.id).pluck(:consultant_role).uniq
		array.to_s.gsub('"', '').gsub('[', '  ').gsub(']', '')
	end

	def all_roles(project_id)
		array = ConsultantTeam.where(consultant_id: self.id, project_id: project_id).pluck(:consultant_role)
		array.to_s.gsub('"', '').gsub('[', '  ').gsub(']', '')
	end
	
end
