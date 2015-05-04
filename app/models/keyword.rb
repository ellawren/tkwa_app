# == Schema Information
#
# Table name: keywords
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  key_category_id :integer
#

class Keyword < ActiveRecord::Base

	has_and_belongs_to_many :patterns
	belongs_to :key_category

end
