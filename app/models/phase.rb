# == Schema Information
#
# Table name: phases
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  number      :integer
#  shorthand   :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  full_name   :string(255)
#  description :text
#

class Phase < ActiveRecord::Base
	
	default_scope order('number')

	has_and_belongs_to_many :projects
	has_many :schedule_items

end


