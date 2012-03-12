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
#

class Phase < ActiveRecord::Base
	has_and_belongs_to_many :projects
end


