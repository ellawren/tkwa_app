class PatternGroup < ActiveRecord::Base

  	def display_name
  		"#{self.order}. #{self.name}"
  	end

end
# == Schema Information
#
# Table name: pattern_groups
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  order      :string(255)
#

