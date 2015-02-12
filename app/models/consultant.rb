# == Schema Information
#
# Table name: consultants
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  address             :string(255)
#  phone               :string(255)
#  fax                 :string(255)
#  url                 :string(255)
#  defunct             :boolean         default(FALSE)
#  mbe                 :boolean         default(FALSE)
#  category            :integer
#  notes               :text
#  contractor_category :integer
#  po_box              :string(255)
#  primary             :string(255)
#  temp                :integer
#  location            :string(255)
#  department          :string(255)
#

class Consultant < ActiveRecord::Base

    has_many :contacts

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

    scope :consultants_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 3],
    }	

	scope :contractors_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 5],
    }

    scope :marketing_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 2],
    }	

    scope :suppliers_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 6],
    }	

    scope :architects_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 4],
    }	

    scope :municipal_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 9],
    }		

    scope :developers_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 11],
    }	

    scope :legal_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 12],
    }	

    scope :clients_only, {
        :select => "consultants.*",
        :conditions => ["consultants.category = ?", 1],
    }	

	def contacts
        Contact.where(consultant_id: self.id)
    end

    def name_and_location
        if self.location?
            "#{name} (#{location})"
        else
            name
        end
    end

    def display_name
		s = "#{self.name}" 
		s << " (MBE)" if self.mbe == true
		s << " (Closed)" if self.defunct == true
		s
	end

    def category_name
        Category.find_by_number(self.category).name
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
