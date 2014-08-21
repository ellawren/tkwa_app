# == Schema Information
#
# Table name: non_billable_hours
#
#  id         :integer         not null, primary key
#  hours      :integer
#  year       :integer
#  week       :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  active     :boolean         default(TRUE)
#

class NonBillableHour < ActiveRecord::Base
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
    	data = User.find(self.user_id).data_record
    	self.hours ||= data.hours_in_week.to_i - data.billable_per_week.to_i

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


