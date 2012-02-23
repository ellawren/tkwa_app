# == Schema Information
#
# Table name: services
#
#  id           :integer         not null, primary key
#  service_name :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Service < ActiveRecord::Base
	has_and_belongs_to_many :projects
	default_scope :order => 'service_name ASC'

end
