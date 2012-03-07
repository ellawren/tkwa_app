# == Schema Information
#
# Table name: timesheets
#
#  id          :integer         not null, primary key
#  year        :integer         not null
#  week        :integer         not null
#  employee_id :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Timesheet < ActiveRecord::Base
  default_scope :order => "year DESC, week DESC"
  
  belongs_to :employee
  has_many :time_entries, :dependent => :destroy
  accepts_nested_attributes_for :time_entries, :allow_destroy => true

  YEARS =   [	"2012", "2011" ]
 
end

