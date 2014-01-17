# == Schema Information
#
# Table name: data_records
#
#  id                :integer         not null, primary key
#  year              :integer
#  vacation          :decimal(6, 2)
#  holiday           :decimal(4, 2)
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
#  overage_from_prev :decimal(6, 2)
#  billable_rate     :decimal(5, 2)
#

class DataRecord < ActiveRecord::Base
	default_scope order('year, start_week')
	belongs_to :user

	validates :user_id, :presence => true
	validates :year, :presence => true

	def self.week_array
    	(self.start_week..self.end_week).to_a 
  	end

  	def user_name
  		User.find(self.user_id).name
  	end

	after_initialize :set_defaults

	def set_defaults
	    self.year ||= Date.today.cwyear
	    self.start_week ||= 1
        self.end_week ||= Date.new(Date.today.cwyear, 12, 28).cweek #calc for number of weeks in current year
	    self.hours_in_week ||= 40
	    self.vacation ||= 80
	    self.holiday ||= 8
	    self.billable_rate ||= 90
  	end


end
