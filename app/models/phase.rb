# == Schema Information
#
# Table name: phases
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  number     :integer
#  shorthand  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  full_name  :string(255)
#

class Phase < ActiveRecord::Base
	has_and_belongs_to_many :projects
	has_and_belongs_to_many :potential_projects

	has_many :schedule_items

end


