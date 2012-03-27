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

  has_many :non_billable_entries, :dependent => :destroy
  accepts_nested_attributes_for :non_billable_entries, :allow_destroy => true, :reject_if => lambda { |a| a[:category].blank? }

  YEARS =   [	"2012", "2011" ]

  NON_BILLABLE_CATEGORIES =   [ "Admin Meeting", "Computer Systems", "Education/Training", "Marketing", "Staff/Scheduling Meeting",  
                                "Studio Projects", "Sustainable Research", "Vacation" ]

  def total_hours
  	time_entries.sum(:day1) +  
  	time_entries.sum(:day2) + 
  	time_entries.sum(:day3) + 
  	time_entries.sum(:day4) + 
  	time_entries.sum(:day5) + 
  	time_entries.sum(:day6) + 
  	time_entries.sum(:day7) 
  end

  def nb_total_hours
    non_billable_entries.sum(:day1) +  
    non_billable_entries.sum(:day2) + 
    non_billable_entries.sum(:day3) + 
    non_billable_entries.sum(:day4) + 
    non_billable_entries.sum(:day5) + 
    non_billable_entries.sum(:day6) + 
    non_billable_entries.sum(:day7) 
  end

  def timesheet_total
    total_hours + nb_total_hours
  end





end

