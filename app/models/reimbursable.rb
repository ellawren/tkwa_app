# == Schema Information
#
# Table name: reimbursables
#
#  id                :integer         not null, primary key
#  reimbursable_name :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

class Reimbursable < ActiveRecord::Base
	has_and_belongs_to_many :projects
	has_and_belongs_to_many :potential_projects
end
