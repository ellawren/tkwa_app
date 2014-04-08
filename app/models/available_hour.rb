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
#


class AvailableHour < ActiveRecord::Base

	belongs_to :user

	scope :current, {
        :select => "available_hours.*",
        :joins => "INNER JOIN users ON users.id = available_hours.user_id", 
        :conditions => ["active = ?", true ]
    }

	after_initialize do
    	self.hours ||= User.find(self.user_id).data_record.hours_in_week.to_i
    end
end

