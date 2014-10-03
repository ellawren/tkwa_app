# == Schema Information
#
# Table name: imperatives
#
#  id         :integer         not null, primary key
#  category   :string(255)
#  name       :string(255)
#  number     :integer
#  short_desc :text
#  full_desc  :text
#  strategies :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  petal_id   :integer
#

class Imperative < ActiveRecord::Base
  
  	belongs_to :petal

  	def parent_petal
  		if self.petal_id
  			Petal.find(self.petal_id)
  		end
  	end

end

