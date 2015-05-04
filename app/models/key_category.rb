# == Schema Information
#
# Table name: key_categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class KeyCategory < ActiveRecord::Base
	default_scope order('id ASC')
  	has_many :keywords

end

