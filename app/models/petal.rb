# == Schema Information
#
# Table name: petals
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  numerical_order :integer
#  intent          :text
#  conditions      :text
#  subtitle        :string(255)
#  short_desc      :text
#

class Petal < ActiveRecord::Base

	has_many :imperatives

	def formatted_number
		self.numerical_order.to_s.rjust(2, '0')
	end

	# next/prev
    scope :next, lambda {|numerical_order| where("numerical_order > ?", numerical_order).order("numerical_order ASC") }
    scope :previous, lambda {|numerical_order| where("numerical_order < ?", numerical_order).order("numerical_order DESC") }

    def next
        Petal.next(self.numerical_order).first
    end

    def previous
        Petal.previous(self.numerical_order).first
    end
    #------------------------------------

  
end

