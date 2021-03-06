# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  number     :integer
#

class Category < ActiveRecord::Base

	has_and_belongs_to_many :contacts

	scope :consultant_list, {
        :select => "categories.*",
        :conditions => ["number != ? AND number != ?", 7,8],
        :order => "number ASC",
    }	
	
end
