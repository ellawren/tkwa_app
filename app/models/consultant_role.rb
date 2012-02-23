# == Schema Information
#
# Table name: consultant_roles
#
#  id                   :integer         not null, primary key
#  consultant_role_name :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

class ConsultantRole < ActiveRecord::Base
	has_and_belongs_to_many :projects
end
