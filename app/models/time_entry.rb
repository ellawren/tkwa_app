# == Schema Information
#
# Table name: time_entries
#
#  id           :integer         not null, primary key
#  timesheet_id :integer
#  project_id   :integer
#  task         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  day1         :decimal(4, 2)
#  day2         :decimal(4, 2)
#  day3         :decimal(4, 2)
#  day4         :decimal(4, 2)
#  day5         :decimal(4, 2)
#  day6         :decimal(4, 2)
#  day7         :decimal(4, 2)
#  employee_id  :integer
#  phase_number :integer
#

class TimeEntry < ActiveRecord::Base
  default_scope joins(:project).order('projects.name ASC, phase_number ASC')
  belongs_to :timesheet
  belongs_to :project
  
  validates_presence_of :phase_number, :message => "must be selected"


  def entry_total
        d1 = day1 || 0
        d2 = day2 || 0
        d3 = day3 || 0
        d4 = day4 || 0
        d5 = day5 || 0
        d6 = day6 || 0
        d7 = day7 || 0
        d1 + d2 + d3 + d4 + d5 + d6 + d7
    end   

end

