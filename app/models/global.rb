# == Schema Information
#
# Table name: globals
#
#  id         :integer         not null, primary key
#  year       :integer
#  multiplier :decimal(4, 2)
#  mileage    :decimal(4, 2)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Global < ActiveRecord::Base

	before_save :set_defaults

	def set_defaults
		self.multiplier ||= 2.8
		self.mileage ||= 0.51
	end

	# used for employee data records
	AVAILABLE_YEARS =  [ [2014, 2014], [2013, 2013] ]

end

