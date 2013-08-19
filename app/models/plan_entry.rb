class PlanEntry < ActiveRecord::Base
	belongs_to :employee
  	belongs_to :project

end
# == Schema Information
#
# Table name: plan_entries
#
#  id          :integer         not null, primary key
#  employee_id :integer         not null
#  project_id  :integer         not null
#  hours       :integer(3)
#  year        :integer         not null
#  week        :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

