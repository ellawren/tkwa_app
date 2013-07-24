class ScheduleItem < ActiveRecord::Base
	default_scope order('phase_id, start')
	belongs_to :project
	belongs_to :phase

	validates :start, 	presence: true
	validates :end, 	presence: true
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
#

