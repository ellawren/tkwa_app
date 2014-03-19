class Subject < ActiveRecord::Base

	validates :name, presence: true
	validates :number, presence: true

	def display_name
		"#{number} - #{name}"
	end

end
# == Schema Information
#
# Table name: subjects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  number     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

