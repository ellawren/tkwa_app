# == Schema Information
#
# Table name: unassigned_hours
#
#  id         :integer         not null, primary key
#  hours      :integer
#  project_id :integer
#  year       :integer
#  week       :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  active     :boolean         default(TRUE)
#

class UnassignedHour < ActiveRecord::Base
  	default_scope order('year, week')
  	belongs_to :project

  	def self.all_by_week(w,y)
        UnassignedHour.where(:week => w, :year => y).sum(:hours)
    end

    scope :active, where(:active => true)

    after_initialize do
    	test = Date.commercial(self.year, self.week, 1) - 1 
    	curr = Date.commercial(Date.today.year, Date.today.cweek, 1) - 1
    	end_range = curr + 15.weeks
    	begin_range = curr - 2.weeks
    	if test <= end_range && test >= begin_range
    		self.active = true
    	else
    		self.active = false
    	end
    end

end