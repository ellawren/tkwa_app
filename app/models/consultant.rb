# == Schema Information
#
# Table name: consultants
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  address       :string(255)
#  phone         :string(255)
#  fax           :string(255)
#  url           :string(255)
#  defunct       :boolean         default(FALSE)
#  mbe           :boolean         default(FALSE)
#  category      :integer
#  po_box        :string(255)
#  general_email :string(255)
#

class Consultant < ActiveRecord::Base

	has_many :consultant_teams
	has_many :projects, :through => :consultant_teams,  :select => 'distinct projects.*'

 	has_many :consultant_reviews, :dependent => :destroy
    accepts_nested_attributes_for :consultant_reviews, :allow_destroy => true, :reject_if => lambda { |a| a[:consultant_id].blank? || a[:consultant_role_id].blank? }

	before_save do
        self.phone = self.phone.to_s.gsub(/\D/, '')
        self.fax = self.fax.to_s.gsub(/\D/, '')
    end

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
	
	def display_name
		s = "#{self.name}" 
		s << " (MBE)" if self.mbe == true
		s << " (Closed)" if self.defunct == true
		s
	end

	def all_projects #need to use this instead of calling via the association to get alpha sort
		array = ConsultantTeam.where(consultant_id: self.id).pluck(:project_id).uniq
		Project.alpha.find(array)
	end

	def roles 
		array = ConsultantReview.where(consultant_id: self.id).pluck(:consultant_role_id).uniq
		roles = []
		array.each do |c|
			roles.push(ConsultantRole.find(c).consultant_role_name)
		end

		roles.join(", ")
	end

	def all_roles(project_id)
		array = ConsultantTeam.where(consultant_id: self.id, project_id: project_id).pluck(:consultant_role)
		array.to_s.gsub('"', '').gsub('[', '  ').gsub(']', '')
	end
	
end
