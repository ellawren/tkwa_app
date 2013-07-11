# == Schema Information
#
# Table name: services
#
#  id           :integer         not null, primary key
#  service_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  description  :text
#

class Service < ActiveRecord::Base
	has_and_belongs_to_many :projects
	has_and_belongs_to_many :potential_projects
	#default_scope :order => 'service_name ASC'

end
