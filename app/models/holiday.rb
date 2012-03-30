# == Schema Information
#
# Table name: holidays
#
#  id         :integer         not null, primary key
#  date       :date
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Holiday < ActiveRecord::Base
	default_scope :order => "date ASC"

end


