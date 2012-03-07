# == Schema Information
#
# Table name: timesheets
#
#  id         :integer         not null, primary key
#  year       :integer         not null
#  week       :integer         not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  hours      :decimal(6, 2)
#  phase      :string(255)
#  task       :string(255)
#

class Timesheet < ActiveRecord::Base
	has_many :employee_timesheets
    has_many :employees, :through => :employee_timesheets

    has_many :projects_timesheets
    has_many :projects, :through => :projects_timesheets
end


