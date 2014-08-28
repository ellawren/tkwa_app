# == Schema Information
#
# Table name: marketing_categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class MarketingCategory < ActiveRecord::Base
	default_scope order('name ASC')
	has_and_belongs_to_many :projects
end
