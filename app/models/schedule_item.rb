class ScheduleItem < ActiveRecord::Base
	default_scope order('phase_id, start_date')
	belongs_to :project
	belongs_to :phase

	validates :start, 	presence: true
	validates :end, 	presence: true
	validates :phase, 	presence: true
	validates :desc, 	presence: true
	validate :check_duration

	def check_duration
  		errors.add(:duration, "start date must be before end date") if duration == "n/a"
	end

	before_save :date_parse
    def date_parse
        self.start_date = Date.strptime(self.start, "%m/%d/%Y")
    end
end
# == Schema Information
#
# Table name: schedule_items
#
#  id         :integer         not null, primary key
#  project_id :integer
#  phase_id   :integer
#  desc       :string(255)
#  start      :string(255)
#  end        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  duration   :string(255)
#  start_date :date
#  meeting    :string(255)     default("task")
#

