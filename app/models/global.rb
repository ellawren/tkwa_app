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
end

