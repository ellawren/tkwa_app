# == Schema Information
#
# Table name: consultant_reviews
#
#  id                 :integer         not null, primary key
#  consultant_id      :integer
#  consultant_role_id :integer
#  recommendation     :integer         default(3)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  notes              :string(255)
#  name               :string(255)
#  role               :string(255)
#

class ConsultantReview < ActiveRecord::Base
	default_scope order("name ASC, role ASC")
  	belongs_to :consultant
  	has_one :consultant_role

  	validates :consultant_id, :presence => true
    validates :consultant_role_id, :presence => true

  	before_save do
        self.name = self.consultant_name
        self.role = self.consultant_role_name
    end

  	def consultant
		Consultant.find(self.consultant_id)
	end

	def consultant_name
		Consultant.find(self.consultant_id).name
	end

  	def consultant_role
		ConsultantRole.find(self.consultant_role_id)
	end

	def consultant_role_name
		self.consultant_role.consultant_role_name
	end

	def rec
		if self.recommendation == 1
			"yes" 
		elsif self.recommendation == 2
			"no" 
		elsif self.recommendation == 3
			"undecided" 
		elsif self.recommendation == 4
			"defunct" 
		end
	end

end
