# == Schema Information
#
# Table name: timesheets
#
#  id            :integer         not null, primary key
#  year          :integer         not null
#  week          :integer         not null
#  employee_id   :integer         not null
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  selected_year :integer
#

class Timesheet < ActiveRecord::Base
  default_scope :order => "year DESC, week DESC"
  
  belongs_to :employee
  has_many :time_entries, :dependent => :destroy
  accepts_nested_attributes_for :time_entries, :allow_destroy => true, :reject_if => lambda { |a| a[:project_id].blank? }

  YEARS =   [	"2012", "2011" ]

  def total_hours
  	time_entries.sum(:day1) +  
  	time_entries.sum(:day2) + 
  	time_entries.sum(:day3) + 
  	time_entries.sum(:day4) + 
  	time_entries.sum(:day5) + 
  	time_entries.sum(:day6) + 
  	time_entries.sum(:day7) 
  end

end

