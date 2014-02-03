# == Schema Information
#
# Table name: projects_timesheets
#
#  id           :integer         not null, primary key
#  project_id   :integer
#  timesheet_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class ProjectsTimesheets < ActiveRecord::Base

	belongs_to :project
    belongs_to :timesheet
    
end


