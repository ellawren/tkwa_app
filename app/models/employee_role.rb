# == Schema Information
#
# Table name: employee_roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class EmployeeRole < ActiveRecord::Base

	default_scope :order => "created_at"
	
	has_and_belongs_to_many :projects
	has_and_belongs_to_many :potential_projects

end