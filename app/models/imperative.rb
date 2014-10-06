# == Schema Information
#
# Table name: imperatives
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  number     :integer
#  short_desc :text
#  full_desc  :text
#  petal_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Imperative < ActiveRecord::Base

  	belongs_to :petal

  	def parent_petal
  		if self.petal_id
  			Petal.find(self.petal_id)
  		end
  	end

  	def formatted_number
		self.number.to_s.rjust(2, '0')
	end

  	# next/prev
    scope :next, lambda {|number| where("number > ?", number).order("number ASC") }
    scope :previous, lambda {|number| where("number < ?", number).order("number DESC") }

    def next
        Imperative.next(self.number).first
    end

    def previous
        Imperative.previous(self.number).first
    end
    #------------------------------------

end

