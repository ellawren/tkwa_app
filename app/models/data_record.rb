# == Schema Information
#
# Table name: data_records
#
#  id                :integer         not null, primary key
#  year              :integer
#  vacation          :decimal(6, 2)
#  holiday           :decimal(4, 2)
#  billable          :decimal(6, 2)
#  rate              :decimal(6, 2)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  admin_meeting     :decimal(6, 2)
#  computer          :decimal(6, 2)
#  education         :decimal(6, 2)
#  marketing         :decimal(6, 2)
#  staff_meeting     :decimal(6, 2)
#  stdio_projects    :decimal(6, 2)
#  research          :decimal(6, 2)
#  user_id           :integer         not null
#  pay_type          :string(255)     default("Salary")
#  vacation_rollover :decimal(5, 2)
#  start_week        :integer
#  end_week          :integer
#  hours_in_week     :decimal(4, 2)
#

class DataRecord < ActiveRecord::Base
	belongs_to :user

	validates :user_id, :presence => true
	validates :year, :presence => true

	def billable_rate
		if rate?
			if Global.find_by_year(year)
				multiplier = Global.find_by_year(year).multiplier || 2.8
			else
				multiplier = 2.8
			end
			rate * (multiplier + 1)
		end
	end
	before_create :set_defaults

	def set_defaults
	    
	    if self.year != nil
	    	prev_year = (self.year - 1)

	    	if DataRecord.find_all_by_user_id_and_year(self.user_id, prev_year).count == 1
	    		prev = DataRecord.find_by_user_id_and_year(self.user_id, prev_year)
		    	if prev.hours_in_week != nil
		    		self.hours_in_week = prev.hours_in_week
		    	else
		    		self.hours_in_week = 40
		    	end
		    	if prev.vacation != nil
		    		self.vacation = prev.vacation
		    	else
		    		self.vacation = 80
		    	end
		    	if prev.holiday != nil
		    		self.holiday = prev.holiday
		    	else
		    		self.holiday = 8
		    	end
		    	if prev.billable != nil
		    		self.billable = prev.billable
		    	else
		    		self.billable = 39.5
		    	end
		    	if prev.rate != nil
		    		self.rate = prev.rate
		    	else
		    		self.rate = 24
		    	end
		    else
		    	self.hours_in_week = 40
		    	self.vacation = 80
		    	self.holiday = 8
		    	self.billable = 39.5
		    	self.rate = 24
	    	end

	    else
	    	self.year = this_year
	    	self.hours_in_week = 40
	    	self.vacation = 80
	    	self.holiday = 8
	    	self.billable = 39.5
	    	self.rate = 24
	    end

	    self.start_week ||= 1
        self.end_week ||= Date.new(self.year, 12, 28).cweek #calc for number of weeks in current year

  end


end
