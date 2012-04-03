# == Schema Information
#
# Table name: data_records
#
#  id          :integer         not null, primary key
#  year        :integer
#  week        :decimal(4, 2)
#  vacation    :decimal(6, 2)
#  holiday     :decimal(4, 2)
#  billable    :decimal(6, 2)
#  rate        :decimal(6, 2)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  employee_id :integer
#

class DataRecord < ActiveRecord::Base
	belongs_to :employee

	validates :employee_id, :presence => true
	validates :year, :presence => true

	def billable_rate
		if rate?
			if Global.find_by_year(year).multiplier?
				multiplier =  Global.find_by_year(year).multiplier
			else
				multiplier = 2.8
			end
			rate * (multiplier + 1)
		end
	end

end
