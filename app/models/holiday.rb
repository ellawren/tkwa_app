# == Schema Information
#
# Table name: holidays
#
#  id          :integer         not null, primary key
#  date        :string(255)
#  name        :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  date_object :date
#  year        :integer
#  week        :integer
#  day         :integer
#

class Holiday < ActiveRecord::Base
    
	default_scope :order => "date_object ASC"

	before_save :date_parse
    def date_parse
        self.date_object = Date.strptime(self.date, "%m/%d/%Y")
    	self.year = date_object.year
    	self.week = date_object.cweek
    	self.day = date_object.wday + 1
    end

	def date_formatted
		date_object.strftime("%B %-d (%a)")
	end

    # this is used for the calendar on timesheets index --> https://github.com/excid3/simple_calendar
    def start_time
        date_object.to_datetime
    end

end


