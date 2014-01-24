class Bill < ActiveRecord::Base
    default_scope order('created_at')
	belongs_to :consultant_team

	def bills_total(team_id)
        bills = Bill.find_all_by_consultant_team_id(team_id)
        array = []
        sum = 0
        bills.each do |t| 
            array.push(t.amount)
        end
        array.map{|x| sum += x}
        sum
    end

    def amount=(num)
        num.gsub!(/[$,\s]/,'') if num.is_a?(String)
        self[:amount] = num.to_f
    end
end
# == Schema Information
#
# Table name: bills
#
#  id                 :integer         not null, primary key
#  date               :string(255)
#  amount             :decimal(, )
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  consultant_team_id :integer         not null
#

