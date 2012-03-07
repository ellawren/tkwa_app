# == Schema Information
#
# Table name: employee_timesheets
#
#  id           :integer         not null, primary key
#  employee_id  :integer
#  timesheet_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class EmployeeTimesheet < ActiveRecord::Base
    attr_accessible :employee_id, :timesheet_id

    belongs_to :employee
    belongs_to :timesheet

	validates :employee_id, :presence => true
   	validates :timesheet_id, :presence => true
end


