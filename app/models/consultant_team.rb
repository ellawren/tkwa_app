# == Schema Information
#
# Table name: consultant_teams
#
#  id                  :integer         not null, primary key
#  project_id          :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  consultant_role     :string(255)
#  consultant_contract :decimal(12, 2)
#  consultant_name     :string(255)
#

class ConsultantTeam < ActiveRecord::Base
    default_scope order('created_at')

    validates :project_id, :presence => true
    validates :consultant_name, :presence => true

	belongs_to :project
    has_many :bills, :dependent => :destroy
    accepts_nested_attributes_for :bills, :allow_destroy => true, :reject_if => lambda { |a| a[:amount].blank? }

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
        if consultant_bills_total.present? && consultant_contract.present?
            unless consultant_bills_total == 0 || consultant_contract == 0
                ( consultant_bills_total.to_f/consultant_contract.to_f ) * 100
            end
        end
    end

    def remaining
        if consultant_bills_total && consultant_contract
            consultant_contract.to_f - consultant_bills_total.to_f
        end
    end

end
