# == Schema Information
#
# Table name: consultant_teams
#
#  id                  :integer         not null, primary key
#  project_id          :integer
#  consultant_id       :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  consultant_role     :string(255)
#  consultant_contract :decimal(12, 2)
#

class ConsultantTeam < ActiveRecord::Base

	belongs_to :project
	belongs_to :consultant
  has_many :bills, :dependent => :destroy
  accepts_nested_attributes_for :bills, :allow_destroy => true, :reject_if => lambda { |a| a[:consultant_team_id].blank? }

	validates :project_id, :presence => true
  validates :consultant_id, :presence => true

   	def consultant_contract=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:consultant_contract] = num
    end

    def consultant_bills_total
        bills = Bill.find_all_by_consultant_team_id(self.id)
        array = []
        sum = 0
        bills.each do |t| 
            array.push(t.amount)
        end
        array.map{|x| sum += x}
        sum
    end

    def percent_billed
      if consultant_bills_total && consultant_contract
        ( consultant_bills_total.to_f/consultant_contract.to_f ) * 100
      end
    end

   	CONSULTANT_ROLES =   [	"HVAC", "MEP Engineering", "Landscape Design", "Fire Protection",
   						"Structural Engineering", "Civil Engineering", "Acoustics", "A/V",
   						"Plumbing"
    				 ]

end
