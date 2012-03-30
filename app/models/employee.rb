# == Schema Information
#
# Table name: employees
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  contact_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  number         :integer
#  status         :string(255)
#  hire_date      :date
#  leave_date     :date
#  week_hours     :decimal(4, 2)
#  vacation_hours :decimal(6, 2)
#  holiday_hours  :decimal(4, 2)
#  billable_goal  :decimal(4, 2)
#

class Employee < ActiveRecord::Base
	belongs_to :user
    belongs_to :contact

    has_many :timesheets
    has_many :time_entries, :through => :timesheets
end
