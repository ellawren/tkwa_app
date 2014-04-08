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
#

class NonBillableHour < ActiveRecord::Base

  	belongs_to :user

	scope :current, {
        :select => "available_hours.*",
        :joins => "INNER JOIN users ON users.id = available_hours.user_id", 
        :conditions => ["active = ?", true ]
    }

    after_initialize do
    	data = User.find(self.user_id).data_record
    	self.hours ||= data.hours_in_week.to_i - data.billable_per_week.to_i
    end

end


