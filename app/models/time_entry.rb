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
#  phase_number :integer
#  user_id      :integer         not null
#  total        :decimal(5, 2)
#  year         :integer
#

class TimeEntry < ActiveRecord::Base

    default_scope joins(:project).order('projects.name ASC, phase_number ASC, task ASC, created_at ASC').readonly(false)
    belongs_to :timesheet
    belongs_to :project
  
    validates_presence_of :project_id, :phase_number, :task

    before_save :record_total

    # next/prev
    scope :previous, lambda {|ti, pr| where("timesheet_id = ? AND project_id = ?", ti, pr)}

    def previous?
        unless TimeEntry.previous(self.timesheet_id, self.project_id).blank?
        	if TimeEntry.previous(self.timesheet_id, self.project_id).first.id == self.id
	        	false
	        else
	        	true
	        end
        end
    end
    #------------------------------------

    private
    def record_total
      self.total = day1.to_f + day2.to_f + day3.to_f + day4.to_f + day5.to_f + day6.to_f + day7.to_f
    end

end

