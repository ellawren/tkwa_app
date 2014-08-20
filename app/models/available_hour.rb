# == Schema Information
#
# Table name: available_hours
#
#  id         :integer         not null, primary key
#  hours      :integer
#  user_id    :integer
#  year       :integer
#  week       :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  active     :boolean         default(TRUE)
#


class AvailableHour < ActiveRecord::Base
	default_scope order('year, week')
	belongs_to :user

	scope :active, where(:active => true)

	scope :current, {
        :select => "available_hours.*",
        :joins => "INNER JOIN users ON users.id = available_hours.user_id", 
        :conditions => ["users.active = ?", true ]
    }

    def set_active 
        # this used to be called on after_initialize but it's crazy slow, so I need to find a better way to do this
        # deactivated on 8/20/14, which will cause problems with forecast ranges in the future
    	self.hours ||= User.find(self.user_id).data_record.hours_in_week.to_i

    	test = Date.commercial(self.year, self.week, 1) - 1 
    	curr = Date.commercial(Date.today.year, Date.today.cweek, 1) - 1
    	end_range = curr + 15.weeks
    	begin_range = curr - 2.weeks
    	if test <= end_range && test >= begin_range
    		self.active = true
    	else
    		self.active = false
    	end
    end
end

