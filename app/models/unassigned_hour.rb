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
#

class UnassignedHour < ActiveRecord::Base
  
  	belongs_to :project

end
