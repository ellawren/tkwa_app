# == Schema Information
#
# Table name: consultants
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Consultant < ActiveRecord::Base
	
end
