# == Schema Information
#
# Table name: employees
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#  number     :integer
#  status     :string(255)
#  hire_date  :date
#  leave_date :date
#

class Employee < ActiveRecord::Base
	belongs_to :user
    belongs_to :contact

    has_many :employee_timesheets, :dependent => :destroy
    has_many :timesheets, :through => :employee_timesheets

    accepts_nested_attributes_for :employee_timesheets, :allow_destroy => true, :reject_if => lambda { |a| a[:timesheet_id].blank? }
    accepts_nested_attributes_for :timesheets

end
