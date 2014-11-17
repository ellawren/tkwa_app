# == Schema Information
#
# Table name: organizations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  address    :string(255)
#  phone      :string(255)
#  website    :string(255)
#  fax        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  category   :integer
#

class Organization < ActiveRecord::Base

	before_save do
        self.phone = self.phone.to_s.gsub(/\D/, '')
        self.fax = self.fax.to_s.gsub(/\D/, '')
    end

	# next/prev
    scope :next, lambda {|id| where("id > ?", id).order("id ASC") }
    scope :previous, lambda {|id| where("id < ?", id).order("id DESC") }

    def next
        Organization.next(self.id).first
    end

    def previous
        Organization.previous(self.id).first
    end
    #------------------------------------
  
end
